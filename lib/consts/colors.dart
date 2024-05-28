import 'package:flutter/material.dart';

const colors = [
  Color(0xff000000), // 0
  Color(0xFF082722), // 1
  Color(0xff18413b), // 2
  Color(0xff2e746a), // 3
  Color(0xff97cc98), // 4 꺼졌을시 시간제어 버튼색
  Color(0xffd9f0ba), // 5 얇은 선 색 및 메뉴 버튼 색
  Color(0xffffffff), // 6
  Color(0xff429e99), //7
  Color(0xffe2f397), //8
  Color(0xff3b5b56), //9
  Color(0xffd1746a), //10
];

class UnitCardColor {
  final Color bg;
  final Color icon;
  final Color labelFont;
  final Color onOff;
  final Color onOffFont;

  final Color timeControl;
  final Color timeControlFont;

  final Color auto;
  final Color autoFont;

  final Color manual;
  final Color manualFont;

  UnitCardColor({
    required this.bg,

    required this.icon,
    required this.labelFont,
    required this.onOff,
    required this.onOffFont,
    required this.timeControl,
    required this.timeControlFont,
    required this.auto,
    required this.autoFont,
    required this.manual,
    required this.manualFont,
  });
}


final CARDS = [
  UnitCardColor(
    bg: const Color(0xffffffff),
    icon: const Color(0xff1d2b2b),
    labelFont: const Color(0xff000000),
    onOff: const Color(0xff429e99),
    onOffFont: const Color(0xffffffff),
    timeControl: const Color(0xff082722),
    timeControlFont: const Color(0xffffffff),
    auto: const Color(0xffdadada),
    autoFont: const Color(0xff7b7b7b),
    manual: const Color(0xff30736a),
    manualFont: const Color(0xffffffff),
  ),
  UnitCardColor(
    bg: const Color(0xff082722),
    icon: const Color(0xff687e7b),
    labelFont: const Color(0xff687e7b),
    onOff: const Color(0xff000000),
    onOffFont: const Color(0xffffffff),
    timeControl: const Color(0xff97cc98),
    timeControlFont: const Color(0xffffffff),
    auto: const Color(0xff051e1a),
    autoFont: const Color(0xff7b7b7b),
    manual: const Color(0xff30736a),
    manualFont: const Color(0xffffffff),
  ),
];

