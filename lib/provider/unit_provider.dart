import 'package:flutter/material.dart';
import 'package:smart_farm/consts/units.dart';

class UnitProvider extends ChangeNotifier {
  final UNITS = [
    UnitInfo(
      icon: Icons.lightbulb_outline,
      label: 'LED',
      status: true,
      count: 4,
    ),
    UnitInfo(
      icon: Icons.blinds,
      label: '차광막',
      status: true,
      count: 4,
    ),
    UnitInfo(
      icon: Icons.view_agenda_outlined,
      label: '가스제어기',
      status: false,
      count: 4,
    ),
    UnitInfo(
      icon: Icons.air_outlined,
      label: '냉난방기',
      status: false,
      count: 4,
    ),
    UnitInfo(
      icon: Icons.cyclone_outlined,
      label: '환기팬',
      status: true,
      count: 4,
    ),
    UnitInfo(
      icon: Icons.all_inclusive_rounded,
      label: '유동팬',
      status: true,
      count: 4,
    ),
    UnitInfo(
      icon: Icons.water_drop_outlined,
      label: '펌프',
      status: false,
      count: 4,
    ),
  ];

  /// 끌때는 한번에 다 꺼지게,
  /// 켤때는 한번에 다 안 켜지고 각각 켜도록
  offAll() {
    UNITS.map((unit) => unit.status = false);
    notifyListeners();
  }

  /// 카드 에서 버튼을 누르면 개별 장치만 켜지게
  eachControl(String inputLabel) {
    UNITS
        .where((unit) => unit.label == inputLabel)
        .map((unit) => unit.status = !unit.status).toList();
    notifyListeners();
  }
}
