import 'package:flutter/material.dart';

class SensorInfo {
  String sensorName;
  int setChannel;
  double max;
  double min;
  bool isSelected;
  Color color;

  SensorInfo({
    required this.sensorName,
    required this.setChannel,
    required this.max,
    required this.min,
    required this.color,
    required this.isSelected,
  });

  // JSON으로 변환
  Map<String, dynamic> toJson() => {
        'unitName': sensorName,
        'setChannel': setChannel,
        'max': max,
        'min': min,
        'color': color,
        'isSelected': isSelected
      };

  // JSON에서 객체 생성
  factory SensorInfo.fromJson(Map<String, dynamic> json) => SensorInfo(
        sensorName: json['unitName'],
        setChannel: json['setChannel'],
        max: json['max'],
        min: json['min'],
        color: json['color'],
        isSelected: json['isSelected'],
      );
}

final List<SensorInfo> SENSORS = [
  SensorInfo(
    sensorName: '온도',
    setChannel: 0,
    min: 0,
    max: 50,
    isSelected: true,
    color: Colors.red,
  ),
  SensorInfo(
    sensorName: '습도',
    setChannel: 1,
    min: 0,
    max: 100,
    isSelected: false,
    color: Colors.orange,
  ),
  SensorInfo(
    sensorName: '대기압',
    setChannel: 2,
    min: 0,
    max: 3000,
    isSelected: false,
    color: Colors.yellow,
  ),
  SensorInfo(
      sensorName: '조도',
      setChannel: 3,
      min: 0,
      max: 100000,
      isSelected: false,
      color: Colors.green),
  SensorInfo(
    sensorName: '이산화탄소',
    setChannel: 4,
    min: 0,
    max: 3000,
    isSelected: false,
    color: Colors.blue,
  ),
  SensorInfo(
      sensorName: '산성도',
      setChannel: 5,
      min: 0,
      max: 10,
      isSelected: false,
      color: Colors.indigo),
  SensorInfo(
    sensorName: '토양 온도',
    setChannel: 6,
    min: 0,
    max: 50,
    isSelected: false,
    color: Colors.purple,
  ),
  SensorInfo(
    sensorName: '토양 습도',
    setChannel: 7,
    min: 0,
    max: 100,
    isSelected: false,
    color: Colors.white,
  ),
  SensorInfo(
    sensorName: '전기 전도도',
    setChannel: 8,
    min: 0,
    max: 10,
    isSelected: false,
    color: Colors.black,
  ),
];
