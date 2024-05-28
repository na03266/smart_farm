import 'package:flutter/material.dart';

class TabInfo {
  final IconData icon;
  final String label;

  TabInfo({
    required this.icon,
    required this.label,
  });
}

final TABS = [
  TabInfo(
    icon: Icons.bar_chart,
    label: '대시보드',
  ),
  TabInfo(
    icon: Icons.device_hub_rounded,
    label: '장치관리',
  ),
  TabInfo(
    icon: Icons.settings,
    label: '설정',
  ),
];
