import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_farm/database/drift.dart';
import 'package:smart_farm/model/device_value_data_model.dart';
import 'package:smart_farm/model/sensor_value_data_model.dart';
import 'package:smart_farm/model/set_up_data_model.dart';
import 'package:smart_farm/provider/sensor_info.dart';
import 'package:smart_farm/provider/timer_info.dart';
import 'package:smart_farm/provider/unit_info.dart';
import 'package:smart_farm/service/service_save_and_load.dart';

class DataProvider extends ChangeNotifier {
  final AppDatabase _database = AppDatabase();

  SetupData? _setupData;
  DeviceValueData? _deviceValueData;
  SensorValueData? _sensorValueData;
  List<UnitInfo>? _units;
  List<TimerInfo>? _timers;
  List<SensorInfo>? _sensors;

  SetupData? get setupData => _setupData;

  DeviceValueData? get deviceValueData => _deviceValueData;

  SensorValueData? get sensorValueData => _sensorValueData;

  List<UnitInfo>? get units => _units;

  List<TimerInfo>? get timers => _timers;

  List<SensorInfo>? get sensors => _sensors;

  DataProvider() {
    _initializeData();
  }

  Future<void> _initializeData() async {
    _setupData = SetupData.initialValue();
    _deviceValueData = DeviceValueData.initialValue();
    _sensorValueData = SensorValueData.initialValue();

    _units = await loadUnits();
    _timers = await loadTimers();
    _sensors = await loadSensors();

    notifyListeners();
  }

  void updateSetupData(SetupData data) {
    _setupData = data;
    notifyListeners();
  }

  void updateDeviceValueData(DeviceValueData data) {
    _deviceValueData = data;
    notifyListeners();
  }

  Future<void> updateSensorValueData(SensorValueData data) async {
    _sensorValueData = data;
    try {
      await _database.insertSensorData(
        SensorDataTableCompanion.insert(
          temperature: data.sensorValue[0].sensorValue,
          humidity: data.sensorValue[1].sensorValue,
          pressure: data.sensorValue[2].sensorValue,
          lightIntensity: data.sensorValue[3].sensorValue,
          co2: data.sensorValue[4].sensorValue,
          ph: data.sensorValue[5].sensorValue,
          soilTemperature: data.sensorValue[6].sensorValue,
          soilMoisture: data.sensorValue[7].sensorValue,
          electricalConductivity: data.sensorValue[8].sensorValue,
        ),
      );
      // final latestData = await _database.getLatestSensorData();
      //
      // if (latestData != null) {
      //   print('Latest sensor data:');
      //   print('Temperature: ${latestData.temperature}');
      //   print('Humidity: ${latestData.humidity}');
      //   print('Pressure: ${latestData.pressure}');
      //   print('Light Intensity: ${latestData.lightIntensity}');
      //   print('CO2: ${latestData.co2}');
      //   print('pH: ${latestData.ph}');
      //   print('Soil Temperature: ${latestData.soilTemperature}');
      //   print('Soil Moisture: ${latestData.soilMoisture}');
      //   print('Electrical Conductivity: ${latestData.electricalConductivity}');
      // }
    } catch (e) {
      print('Failed to insert sensor data: $e');
      // 여기에 에러 처리 로직을 추가할 수 있습니다.
    }
    notifyListeners();
  }

  /// UnitInfo
  void updateUnitInfo(List<UnitInfo> unitInfo) {
    _units = unitInfo;
    notifyListeners();
  }

  void addUnitInfo(UnitInfo unitInfo) {
    _units!.add(unitInfo);
    notifyListeners();
  }

  void removeUnitInfo(UnitInfo unitInfo) {
    _units!.remove(unitInfo);
    notifyListeners();
  }

  void removeUnitInfoAt(int index) {
    _units!.removeAt(index);
    notifyListeners();
  }

  /// TimerInfo
  void addTimerInfo(TimerInfo timerInfo) {
    _timers!.add(timerInfo);
    notifyListeners();
  }

  void updateTimerInfo(int index, TimerInfo timerInfo) {
    if (index >= 0 && index < _timers!.length) {
      _timers![index] = timerInfo;
      notifyListeners();
    }
  }

  void removeTimerInfo(int id) {
    _timers!.removeWhere((timer) => timer.id == id);
    notifyListeners();
  }

  TimerInfo? getTimerInfoById(int id) {
    return _timers!.firstWhere((timer) => timer.id == id);
  }

  ///Sensors
  void updateSensorInfo(List<SensorInfo> sensorInfo) {
    _sensors = sensorInfo;
    notifyListeners();
  }

  void addSensorInfo(SensorInfo sensorInfo) {
    _sensors!.add(sensorInfo);
    notifyListeners();
  }

  void removeSensorInfoAt(int index) {
    _sensors!.removeAt(index);
    notifyListeners();
  }

  SensorInfo? getSensorInfoByChannel(int channel) {
    return _sensors!.firstWhere((sensor) => sensor.setChannel == channel);
  }

  Future<void> saveAllData() async {
    await saveUnits(_units!);
    await saveTimers(_timers!);
    await saveSensors(_sensors!);
  }
}
