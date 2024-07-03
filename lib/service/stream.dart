import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

class SocketService {
  Socket? _socket;
  final _streamController = StreamController<Uint8List>.broadcast();

  Stream<Uint8List> get stream => _streamController.stream;

  Future<void> connectToServer() async {
    try {
      _socket = await Socket.connect('192.168.0.200', 12345);
      print('Connected to: ${_socket!.remoteAddress.address}:${_socket!.remotePort}');

      _socket!.listen(
            (List<int> data) {
          final Uint8List byteData = Uint8List.fromList(data);
          _streamController.add(byteData);
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

  void dispose() {
    _socket?.destroy();
    _streamController.close();
  }
}
