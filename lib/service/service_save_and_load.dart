import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_farm/provider/sensor_info.dart';
import 'package:smart_farm/provider/timer_info.dart';
import 'package:smart_farm/provider/unit_info.dart';

/// Units
Future<void> saveUnits(List<UnitInfo> units) async {
  final prefs = await SharedPreferences.getInstance();
  final String encodedData = json.encode(
    units.map((unit) => unit.toJson()).toList(),
  );
  await prefs.setString('units', encodedData);
}

Future<List<UnitInfo>> loadUnits() async {
  final prefs = await SharedPreferences.getInstance();
  final String? encodedData = prefs.getString('units');

  if (encodedData == null) {
    return UNITS; // 저장된 데이터가 없으면 초기 UNITS 반환
  }
  final List<dynamic> decodedData = json.decode(encodedData);

  return decodedData.map((item) => UnitInfo.fromJson(item)).toList();
}

/// Timers
Future<void> saveTimers(List<TimerInfo> timers) async {
  final prefs = await SharedPreferences.getInstance();
  final String encodedData = json.encode(
    timers.map((timer) => timer.toJson()).toList(),
  );
  await prefs.setString('timers', encodedData);
}

Future<List<TimerInfo>> loadTimers() async {
  final prefs = await SharedPreferences.getInstance();
  final String? encodedData = prefs.getString('timers');

  if (encodedData == null) {
    return []; // 저장된 데이터가 없으면 초기 UNITS 반환
  }

  final List<dynamic> decodedData = json.decode(encodedData);

  return decodedData.map((item) => TimerInfo.fromJson(item)).toList();
}

/// Sensors
Future<void> saveSensors(List<SensorInfo> sensors) async {
  final prefs = await SharedPreferences.getInstance();
  final String encodedData = json.encode(
    sensors.map((sensor) => sensor.toJson()).toList(),
  );
  await prefs.setString('sensors', encodedData);
}

Future<List<SensorInfo>> loadSensors() async {
  final prefs = await SharedPreferences.getInstance();
  final String? encodedData = prefs.getString('sensors');
  if (encodedData == null) {
    return SENSORS; // 저장된 데이터가 없으면 초기 SENSORS 반환
  }
  final List<dynamic> decodedData = json.decode(encodedData);
  return decodedData.map((item) => SensorInfo.fromJson(item)).toList();
}
