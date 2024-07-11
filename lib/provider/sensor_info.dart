class SensorInfo {
  String unitName;
  int setChannel;
  double max;
  double min;

  SensorInfo({
    required this.unitName,
    required this.setChannel,
    required this.max,
    required this.min,
  });

  // JSON으로 변환
  Map<String, dynamic> toJson() => {
        'unitName': unitName,
        'setChannel': setChannel,
        'max': max,
        'min': min,
      };

  // JSON에서 객체 생성
  factory SensorInfo.fromJson(Map<String, dynamic> json) => SensorInfo(
        unitName: json['unitName'],
        setChannel: json['setChannel'],
        max: json['max'],
        min: json['min'],
      );
}

final List<SensorInfo> SENSORS = [
  SensorInfo(
    unitName: '온도',
    setChannel: 0,
    min: 0,
    max: 50,
  ),
  SensorInfo(
    unitName: '습도',
    setChannel: 1,
    min: 0,
    max: 100,
  ),
  SensorInfo(
    unitName: '대기압',
    setChannel: 2,
    min: 870,
    max: 1080,
  ),
  SensorInfo(
    unitName: '조도',
    setChannel: 3,
    min: 0,
    max: 100000,
  ),
  SensorInfo(
    unitName: '이산화탄소',
    setChannel: 4,
    min: 250 ,
    max: 2000,
  ),
  SensorInfo(
    unitName: '산성도',
    setChannel: 5,
    min: 4,
    max: 9,
  ),
  SensorInfo(
    unitName: '토양 온도',
    setChannel: 6,
    min: 0,
    max: 30,
  ),
  SensorInfo(
    unitName: '토양 습도',
    setChannel: 7,
    min: 0,
    max: 50,
  ),
  SensorInfo(
    unitName: '전기 전도도',
    setChannel: 8,
    min: 0,
    max: 4,
  ),
];