import 'package:drift/drift.dart';

class TimerModel extends Table {
  /// 식별 가능한 ID
  final int id;

  /// 시작 시간
  final DateTime startTime;

  /// 종료시간
  final DateTime endTime;

  /// 할당된 유닛 명
  final String name;

  TimerModel({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.name,
  });
}
