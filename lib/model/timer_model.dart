import 'package:drift/drift.dart';

class TimerTable extends Table {
  /// 식별 가능한 ID
  IntColumn get id => integer().autoIncrement()();

  /// 시작 시간
  DateTimeColumn get startTime => dateTime()();

  /// 종료 시간
  DateTimeColumn get endTime => dateTime()();

  /// 타이머 이름
  TextColumn get timerName => text()();

  /// 할당된 유닛
  /// 2진수 16자리
  TextColumn get activatedUnit => text()();

  /// 생성일자
  DateTimeColumn get createdAt => dateTime().clientDefault(
        () => DateTime.now().toUtc(),
      )();
}
