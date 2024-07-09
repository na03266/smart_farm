import 'package:flutter/foundation.dart';
import 'package:smart_farm/model/device_value_data_model.dart';
import 'package:smart_farm/model/sensor_value_data_model.dart';
import 'package:smart_farm/model/set_up_data_model.dart';
import 'package:smart_farm/provider/timer_serve_data.dart';
import 'package:smart_farm/provider/unit_serve_data.dart';
import 'package:smart_farm/service/service_save_and_load.dart';

class DataProvider extends ChangeNotifier {
  SetupData? _setupData;
  DeviceValueData? _deviceValueData;
  SensorValueData? _sensorValueData;
  List<UnitInfo>? _units;
  List<TimerInfo>? _timers;

  SetupData? get setupData => _setupData;

  DeviceValueData? get deviceValueData => _deviceValueData;

  SensorValueData? get sensorValueData => _sensorValueData;

  List<UnitInfo>? get units => _units;

  List<TimerInfo>? get timers => _timers;

  DataProvider() {
    _initializeData();
  }

  Future<void> _initializeData() async {
    _setupData = SetupData.initialValue();
    _deviceValueData = DeviceValueData.initialValue();
    _sensorValueData = SensorValueData.initialValue();

    _units = await loadUnits();
    _timers = await loadTimers();

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

  void updateSensorValueData(SensorValueData data) {
    _sensorValueData = data;
    notifyListeners();
  }

  /// UnitInfo
  void updateUnitInfo(int index, UnitInfo unitInfo) {
    _units![index] = unitInfo;
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
}
