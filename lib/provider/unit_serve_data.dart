import 'package:flutter/material.dart';

class UnitInfo {
  IconData icon;
  String unitName;
  bool status;
  bool isAuto;
  List<int> setChannel;

  UnitInfo({
    required this.icon,
    required this.unitName,
    required this.status,
    required this.isAuto,
    required this.setChannel,
  });

  // JSON으로 변환
  Map<String, dynamic> toJson() => {
        'icon': icon.codePoint,
        'unitName': unitName,
        'status': status,
        'isAuto': isAuto,
        'setChannel': setChannel,
      };

  // JSON에서 객체 생성
  factory UnitInfo.fromJson(Map<String, dynamic> json) => UnitInfo(
        icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
        unitName: json['unitName'],
        status: json['status'],
        isAuto: json['isAuto'],
        setChannel: List<int>.from(json['setChannel']),
      );
}

final UNITS = [
  UnitInfo(
    icon: Icons.lightbulb_outline,
    unitName: 'LED',
    status: true,
    isAuto: true,
    setChannel: [0, 1, 2, 3, 4],
  ),
  UnitInfo(
    icon: Icons.blinds,
    unitName: '차광막',
    isAuto: true,
    status: true,
    setChannel: [5, 6, 7, 8, 9],
  ),
  UnitInfo(
    icon: Icons.view_agenda_outlined,
    unitName: '가스제어기',
    isAuto: true,
    status: false,
    setChannel: [10],
  ),
  UnitInfo(
    icon: Icons.air_outlined,
    unitName: '냉난방기',
    isAuto: true,
    status: false,
    setChannel: [11],
  ),
  UnitInfo(
    icon: Icons.cyclone_outlined,
    unitName: '환기팬',
    isAuto: true,
    status: true,
    setChannel: [12],
  ),
  UnitInfo(
    icon: Icons.all_inclusive_rounded,
    unitName: '유동팬',
    isAuto: true,
    status: true,
    setChannel: [13],
  ),
  UnitInfo(
    icon: Icons.water_drop_outlined,
    unitName: '펌프',
    isAuto: true,
    status: false,
    setChannel: [14],
  ),
];
