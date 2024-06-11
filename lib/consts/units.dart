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


