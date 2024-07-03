import 'dart:typed_data';

class SetupDevice {
  int unitId;          // 장치 ID
  int unitType;        // 장치 TYPE
  int unitCH;          // 장치 온오프 채널
  int unitOpenCH;      // 장치 오픈 채널(개폐장치)
  int unitCloseCH;     // 장치 클로즈 채널(개폐장치)
  int unitMoveTime;      // 장치 온오프 동작시간
  int unitStopTime;      // 장치 클로즈 동작시간
  int unitOpenTime;    // 장치 오픈 동작시간
  int unitCloseTime;   // 장치 클로즈 동작시간
  int unitOPTime;      // 장치 동작유형 정의 (0-수동, 1-자동(타이머), 2-원격)
  int unitTimerSet;    // 장치 타이머 유형 설정(1~16)

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
}

class SetupSensor {
  int sensorID;                   // 센서 ID
  int sensorCH;                   // 센서 채널
  int sensorReserved;             // 센서 예약어 정의
  double sensorMULT;              // 센서 보정값 계수 (멀티값) A
  double sensorOffSet;            // 센서 보정값 계수 (오프셋값) B
  Uint8List sensorEQ;             // 센서 수식값

  SetupSensor({
    required this.sensorID,
    required this.sensorCH,
    required this.sensorReserved,
    required this.sensorMULT,
    required this.sensorOffSet,
    required this.sensorEQ,
  });
}

class SetupData {
  Uint8List controllerId;             // 컨트롤러 맥주소
  List<int> setTemp;         // 온도 설정(24시간-30분간격)
  int tempGap;               // 냉동기 및 제상히터 온도 편차
  int heatTemp;              // 제상히터 온도 설정
  int iceType;               // 에어컨 또는 냉동기의 타입 정의 (냉동기 0, 에어컨 1 ~ 3)
  int alarmType;             // 알람 모드 정의
  int alarmTempH;            // 최고온도 알람설정
  int alarmTempL;            // 최저온도 알람설정
  Uint8List tel;             // SMS 서비스 전화번호 설정
  int awsBit;                // AWS 클라우드 사용여부
  List<Uint8List> unitTimer;    // 장치 시간 예약 설정
  List<SetupDevice> setDevice;
  List<SetupSensor> setSensor;
  int dummy1;
  int dummy2;
  int crcL;
  int crcH;

  SetupData({
    required this.controllerId,
    required this.setTemp,
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
}