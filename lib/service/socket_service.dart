import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:smart_farm/model/device_value_data_model.dart';
import 'package:smart_farm/model/set_up_data_model.dart';
import 'package:smart_farm/model/sensor_value_data_model.dart';
import 'package:smart_farm/provider/data_provider.dart';
import 'package:smart_farm/service/received_data_parse.dart';
import 'package:smart_farm/service/send_data_parse.dart';

class SocketService {
  Socket? _socket;
  dynamic changedData;
  final DataProvider _dataProvider;

  SocketService(this._dataProvider);

  final _streamController = StreamController<dynamic>.broadcast();

  Stream<dynamic> get stream => _streamController.stream;

  Future<void> connectToServer() async {
    try {
      _socket = await Socket.connect('192.168.0.200', 12345);
      print(
          'Connected to: ${_socket!.remoteAddress.address}:${_socket!.remotePort}');

      _socket!.listen(
        (List<int> data) {
          final Uint8List byteData = Uint8List.fromList(data);

          changedData = parseData(byteData);

          if (changedData is SetupData) {
            _dataProvider.updateSetupData(changedData);
            print('set');
          } else if (changedData is DeviceValueData) {
            _dataProvider.updateDeviceValueData(changedData);
            print('dev');
          } else if (changedData is SensorValueData){
            _dataProvider.updateSensorValueData(changedData);
          }

          _streamController.add(changedData);
        },
        onError: (error) {
          print('Error: $error');
          _streamController.addError(error);
          _socket!.destroy();
        },
        onDone: () {
          print('Server left.');
          _socket!.destroy();
        },
      );
    } catch (e) {
      print('Failed to connect: $e');
      _streamController.addError(e);
    }
  }

  void sendMessage(List<int> message) {
    if (_socket != null) {
      try {
        _socket!.add(message);
      } catch (e) {
        print('메시지 전송 실패: $e');
        _streamController.addError(e);
      }
    } else {
      print('소켓이 연결되지 않았습니다.');
    }
  }

  void sendSetupData2() {
    if (_socket != null) {
      try {
        Uint8List bytes = cmdDataToBytes();
        _socket!.add(bytes);

        print('SetupData sent successfully');
      } catch (e) {
        print('Failed to send SetupData: $e');
        _streamController.addError(e);
      }
    } else {
      print('Socket is not connected');
    }
  }

  void sendSetupData(SetupData setupData) {
    if (_socket != null) {
      try {
        Uint8List bytes = setupDataToBytes(setupData);
        _socket!.add(bytes);
        print('SetupData sent successfully');
      } catch (e) {
        print('Failed to send SetupData: $e');
        _streamController.addError(e);
      }
    } else {
      print('Socket is not connected');
    }
  }

  void sendDeviceValueData(DeviceValueData valueData) {
    if (_socket != null) {
      try {
        Uint8List bytes = deviceValueDataToBytes(valueData);
        _socket!.add(bytes);
        print('SetupData sent successfully');
      } catch (e) {
        print('Failed to send SetupData: $e');
        _streamController.addError(e);
      }
    } else {
      print('Socket is not connected');
    }
  }

  void dispose() {
    _socket?.destroy();
    _streamController.close();
  }
}
