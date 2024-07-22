import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:smart_farm/model/device_value_data_model.dart';
import 'package:smart_farm/model/sensor_value_data_model.dart';
import 'package:smart_farm/model/set_up_data_model.dart';
import 'package:smart_farm/provider/data_provider.dart';
import 'package:smart_farm/service/received_data_parse.dart';
import 'package:smart_farm/service/send_data_parse.dart';

class SocketService {
  Socket? _socket;
  dynamic changedData;
  final DataProvider _dataProvider;
  final _streamController = StreamController<dynamic>.broadcast();
  Timer? _reconnectionTimer;
  bool _isConnecting = false;
  bool _isConnected = false;  // 추가: 연결 상태를 추적하는 변수

  SocketService(this._dataProvider);

  Stream<dynamic> get stream => _streamController.stream;

  Future<void> connectToServer() async {
    if (_isConnecting || _isConnected) return;
    _isConnecting = true;

    try {
      print('Attempting to connect to 192.168.0.200:12345');
      _socket = await Socket.connect('192.168.0.200', 12345, timeout: Duration(seconds: 5));
      print('Connected to: ${_socket!.remoteAddress.address}:${_socket!.remotePort}');
      _isConnecting = false;
      _isConnected = true;  // 연결 성공
      _setupSocketListeners();
      requestData();  // 연결 성공 후 즉시 데이터 요청
    } catch (e) {
      print('Failed to connect: $e');
      _streamController.addError(e);
      _isConnecting = false;
      _isConnected = false;  // 연결 실패
      _scheduleReconnection();
    }
  }

  void _setupSocketListeners() {
    _socket!.listen(
          (List<int> data) {
        final Uint8List byteData = Uint8List.fromList(data);
        changedData = parseData(byteData);
        if (changedData is SetupData) {
          _dataProvider.updateSetupData(changedData);
          print('setup');
        } else if (changedData is DeviceValueData) {
          _dataProvider.updateDeviceValueData(changedData);
          print('device');
        } else if (changedData is SensorValueData) {
          _dataProvider.updateSensorValueData(changedData);
          print('sensor');
        }
        _streamController.add(changedData);
      },
      onError: (error) {
        print('Error: $error');
        _streamController.addError(error);
        _socket?.destroy();
        _isConnected = false;  // 오류 발생 시 연결 상태 업데이트
        _scheduleReconnection();
      },
      onDone: () {
        print('Server left.');
        _socket?.destroy();
        _isConnected = false;  // 연결 종료 시 상태 업데이트
        _scheduleReconnection();
      },
    );
  }

  void _scheduleReconnection() {
    if (_isConnected) return;  // 이미 연결되어 있으면 재연결 시도하지 않음
    _reconnectionTimer?.cancel();
    _reconnectionTimer = Timer(Duration(seconds: 5), () {
      print('Attempting to reconnect...');
      connectToServer();
    });
  }

  void requestData() {
    if (_isConnected && _socket != null) {
      try {
        Uint8List bytes = cmdDataToBytes();
        _socket!.add(bytes);
        print('SetupData sent successfully');
      } catch (e) {
        print('Failed to send SetupData: $e');
        _streamController.addError(e);
        _isConnected = false;  // 전송 실패 시 연결 상태 업데이트
        _scheduleReconnection();
      }
    } else {
      print('Socket is not connected');
      _scheduleReconnection();
    }
  }

  void sendSetupData(SetupData setupData) {
    if (_isConnected && _socket != null) {
      try {
        Uint8List bytes = setupDataToBytes(setupData);
        _socket!.add(bytes);
        print('SetupData sent successfully');
      } catch (e) {
        print('Failed to send SetupData: $e');
        _streamController.addError(e);
        _isConnected = false;  // 전송 실패 시 연결 상태 업데이트
        _scheduleReconnection();
      }
    } else {
      print('Socket is not connected');
      _scheduleReconnection();
    }
  }

  void sendDeviceValueData(DeviceValueData valueData) {
    if (_isConnected && _socket != null) {
      try {
        Uint8List bytes = deviceValueDataToBytes(valueData);
        _socket!.add(bytes);
        print('DeviceValueData sent successfully');
      } catch (e) {
        print('Failed to send DeviceValueData: $e');
        _streamController.addError(e);
        _isConnected = false;  // 전송 실패 시 연결 상태 업데이트
        _scheduleReconnection();
      }
    } else {
      print('Socket is not connected');
      _scheduleReconnection();
    }
  }

  void dispose() {
    _socket?.destroy();
    _streamController.close();
    _reconnectionTimer?.cancel();
    _isConnected = false;
  }
}