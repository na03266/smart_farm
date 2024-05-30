class HighTemperatureInfo {
  double highTemp;
  double highTime;

  HighTemperatureInfo({
    required this.highTemp,
    required this.highTime,
  });

}

List<HighTemperatureInfo> generateHighTempData() {
  List<HighTemperatureInfo> data = [];
  for (int i = 0; i < 49; i++) {
    data.add(HighTemperatureInfo(
      highTemp: 20.0 + i/10, // 임의의 온도 값 설정
      highTime: i.toDouble(),
    ));
  }
  return data;
}

class LowTemperatureInfo {
  double lowTemp;
  double lowTime;

  LowTemperatureInfo({
    required this.lowTemp,
    required this.lowTime,
  });

}

List<LowTemperatureInfo> generateLowTempData() {
  List<LowTemperatureInfo> data = [];
  for (int i = 0; i < 49; i++) {
    data.add(LowTemperatureInfo(
      lowTemp: 10.0 + i/10, // 임의의 온도 값 설정
      lowTime: i.toDouble(),
    ));
  }
  return data;
}
