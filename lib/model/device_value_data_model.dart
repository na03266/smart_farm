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





class DeviceValueData {
  /// crc 포함 124 바이트
  Uint8List controllerId;  // 컨트롤러 고유 아이디
  List<DeviceValue> deviceValue;
  int crcL;
  int crcH;

  DeviceValueData({
    required this.controllerId,
    required this.deviceValue,
    required this.crcL,
    required this.crcH,
  });

  factory DeviceValueData.initialValue() {
    return DeviceValueData(
      controllerId: Uint8List(6),
      deviceValue: List.generate(16, (index) => DeviceValue(unitId: index, unitMode: 0, unitStatus: 0)),
      crcL: 0,
      crcH: 0,
    );
  }
}
