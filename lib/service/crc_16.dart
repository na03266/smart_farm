import 'dart:typed_data';

class CRC16 {
  static int calculateCRC16(Uint8List frame, int bufferSize) {
    int temp = 0xFFFF;
    int flag;

    for (int i = 0; i < bufferSize; i++) {
      temp = temp ^ (frame[i] & 0xFF);
      for (int j = 1; j <= 8; j++) {
        flag = temp & 0x0001;
        temp >>= 1;
        if (flag != 0) {
          temp ^= 0xA001;
        }
      }
    }

    // Reverse byte order.
    int temp2 = temp >> 8;
    temp = (temp << 8) | temp2;
    temp &= 0xFFFF;

    return temp;
  }

  static int calculateCRC16m(Uint8List frame, int bufferSize) {
    int temp = calculateCRC16(frame, bufferSize - 2);
    frame[bufferSize - 2] = ((temp >> 8) & 0xFF);
    frame[bufferSize - 1] = (temp & 0xFF);
    return temp;
  }

  static bool calculateCRC16s(Uint8List frame, int bufferSize) {
    int temp = calculateCRC16(frame, bufferSize - 2);
    return frame[bufferSize - 2] == ((temp >> 8) & 0xFF) &&
        frame[bufferSize - 1] == (temp & 0xFF);
  }
}