import 'package:flutter/material.dart';

class UnitInfo {
  final IconData icon;
  final String label;
  final int count;
  late bool status;

  UnitInfo({
    required this.icon,
    required this.label,
    required this.status,
    required this.count,
  });
}

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
    label: '가스제어',
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
