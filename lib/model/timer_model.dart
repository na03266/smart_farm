import 'package:drift/drift.dart';

class TimerModel extends Table {
  /// 식별 가능한 ID
  final int id;

  /// 시작 시간
  final DateTime startTime;

  /// 종료시간
  final DateTime endTime;

  /// 타이머 이름
  final String name;

  /// 할당된 유닛
  /// 2진수 16자리
  final List<int> activatedUnit;

  TimerModel({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.name,
    required this.activatedUnit
  });
}
