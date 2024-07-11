import 'dart:typed_data';


class SensorValue {
  int sensorId;     // 센서 고유 아이디
  double sensorValue; // 센서 값

  SensorValue({
    required this.sensorId,
    required this.sensorValue,
  });
}

class SensorValueData {
  /// crc 포함 124 바이트
  Uint8List controllerId;  // 컨트롤러 고유 아이디
  List<SensorValue> sensorValue;
  int dummy1;
  int dummy2;
  int crcL;
  int crcH;

  SensorValueData({
    required this.controllerId,
    required this.sensorValue,
    required this.dummy1,
    required this.dummy2,
    required this.crcL,
    required this.crcH,
  });

  factory SensorValueData.initialValue() {
    return SensorValueData(
      controllerId: Uint8List(6),
      sensorValue: List.generate(9, (index) => SensorValue(sensorId: index, sensorValue: 0.0)),
      dummy1: 0,
      dummy2: 0,
      crcL: 0,
      crcH: 0,
    );
  }
}
