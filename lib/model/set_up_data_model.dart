import 'dart:typed_data';

class SetupDevice {
  int unitId;
  int unitType;
  int unitCH;
  int unitOpenCH;
  int unitCloseCH;
  int unitMoveTime;
  int unitStopTime;
  int unitOpenTime;
  int unitCloseTime;
  int unitOPTime;
  int unitTimerSet;

  SetupDevice({
    required this.unitId,
    required this.unitType,
    required this.unitCH,
    required this.unitOpenCH,
    required this.unitCloseCH,
    required this.unitMoveTime,
    required this.unitStopTime,
    required this.unitOpenTime,
    required this.unitCloseTime,
    required this.unitOPTime,
    required this.unitTimerSet,
  });

  factory SetupDevice.initialValue() {
    return SetupDevice(
      unitId: 0,
      unitType: 0,
      unitCH: 0,
      unitOpenCH: 0,
      unitCloseCH: 0,
      unitMoveTime: 0,
      unitStopTime: 0,
      unitOpenTime: 0,
      unitCloseTime: 0,
      unitOPTime: 0,
      unitTimerSet: 0,
    );
  }


}

class SetupSensor {
  int sensorID;
  int sensorCH;
  int sensorReserved;
  double sensorMULT;
  double sensorOffSet;
  Uint8List sensorEQ;

  SetupSensor({
    required this.sensorID,
    required this.sensorCH,
    required this.sensorReserved,
    required this.sensorMULT,
    required this.sensorOffSet,
    required this.sensorEQ,
  });

  factory SetupSensor.initialValue() {
    return SetupSensor(
      sensorID: 0,
      sensorCH: 0,
      sensorReserved: 0,
      sensorMULT: 1.0,
      sensorOffSet: 0.0,
      sensorEQ: Uint8List(256), // 센서 수식값의 길이가 256바이트라고 가정
    );
  }


}

class SetupData {
  Uint8List controllerId; // 컨트롤러 맥주소
  List<int> setTempL; // 온도 설정(24시간-30분간격)
  List<int> setTempH; // 온도 설정(24시간-30분간격)
  int tempGap; // 냉동기 및 제상히터 온도 편차
  int heatTemp; // 제상히터 온도 설정
  int iceType; // 에어컨 또는 냉동기의 타입 정의 (냉동기 0, 에어컨 1 ~ 3)
  int alarmType; // 알람 모드 정의
  int alarmTempH; // 최고온도 알람설정
  int alarmTempL; // 최저온도 알람설정
  Uint8List tel; // SMS 서비스 전화번호 설정
  int awsBit; // AWS 클라우드 사용여부
  List<Uint8List> unitTimer; // 장치 시간 예약 설정
  List<SetupDevice> setDevice;
  List<SetupSensor> setSensor;
  int dummy1;
  int dummy2;
  int crcL;
  int crcH;

  SetupData({
    required this.controllerId,
    required this.setTempL,
    required this.setTempH,
    required this.tempGap,
    required this.heatTemp,
    required this.iceType,
    required this.alarmType,
    required this.alarmTempH,
    required this.alarmTempL,
    required this.tel,
    required this.awsBit,
    required this.unitTimer,
    required this.setDevice,
    required this.setSensor,
    required this.dummy1,
    required this.dummy2,
    required this.crcL,
    required this.crcH,
  });

  factory SetupData.initialValue() {
    return SetupData(
      controllerId: Uint8List(6),
      setTempL: List.filled(48, 0),
      setTempH: List.filled(48, 0),
      tempGap: 0,
      heatTemp: 0,
      iceType: 0,
      alarmType: 0,
      alarmTempH: 0,
      alarmTempL: 0,
      tel: Uint8List(13),
      awsBit: 0,
      unitTimer: List.generate(16, (_) => Uint8List(180)),
      setDevice: List.generate(16, (_) => SetupDevice.initialValue()),
      setSensor: List.generate(8, (_) => SetupSensor.initialValue()),
      dummy1: 0,
      dummy2: 0,
      crcL: 0,
      crcH: 0,
    );
  }


}
