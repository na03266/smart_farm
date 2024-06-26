import 'package:drift/drift.dart';

class TimerTable extends Table {
  /// 식별 가능한 ID
  IntColumn get id => integer().autoIncrement()();

  /// 예약 시간
  TextColumn get bookingTime => text()();

  /// 타이머 이름
  TextColumn get timerName => text()();

  /// 할당된 유닛
  /// 2진수 16자리
  TextColumn get activatedUnit => text()();

  /// 생성 일자
  DateTimeColumn get createdAt => dateTime().clientDefault(
        () => DateTime.now().toUtc(),
      )();
}
