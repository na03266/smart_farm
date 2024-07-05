import 'package:flutter/foundation.dart';
import 'package:smart_farm/model/set_up_data_model.dart';
import 'package:smart_farm/model/value_model.dart';

class DataProvider extends ChangeNotifier {
  SetupData? _setupData;
  ValueData? _valueData;

  SetupData? get setupData => _setupData;
  ValueData? get valueData => _valueData;

  /// 변수 초기화
  DataProvider()
      : _setupData = SetupData.initialValue(),
        _valueData = ValueData.initialValue();

  void updateSetupData(SetupData data) {
    _setupData = data;
    /// 갱신과 동시에 전송하는 로직
    notifyListeners();
  }

  void updateValueData(ValueData data) {
    _valueData = data;
    notifyListeners();
  }

}