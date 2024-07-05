import 'dart:typed_data';

class DeviceValue {
  int unitId;    // 장치 고유 아이디
  int unitMode;  // 장치 모드 설정(자동1 수동0)
  int unitStatus; // 장치 동작 상태 (0-off, 1-on, 2-open, 3-stop, 4-close)

  DeviceValue({
    required this.unitId,
    required this.unitMode,
    required this.unitStatus,
  });
}

class SensorValue {
  int sensorId;     // 센서 고유 아이디
  double sensorValue; // 센서 값

  SensorValue({
    required this.sensorId,
    required this.sensorValue,
  });
}

class ValueData {
  /// crc 포함 124 바이트
  Uint8List controllerId;  // 컨트롤러 고유 아이디
  List<DeviceValue> deviceValue;
  List<SensorValue> sensorValue;
  int dummy1;
  int dummy2;
  int crcL;
  int crcH;

  ValueData({
    required this.controllerId,
    required this.deviceValue,
    required this.sensorValue,
    required this.dummy1,
    required this.dummy2,
    required this.crcL,
    required this.crcH,
  });

  factory ValueData.initialValue() {
    return ValueData(
      controllerId: Uint8List(6),
      deviceValue: List.generate(16, (_) => DeviceValue(unitId: 0, unitMode: 0, unitStatus: 0)),
      sensorValue: List.generate(8, (_) => SensorValue(sensorId: 0, sensorValue: 0.0)),
      dummy1: 0,
      dummy2: 0,
      crcL: 0,
      crcH: 0,
    );
  }
}



