import 'package:drift/drift.dart';

class TimerTable extends Table {
  /// 식별 가능한 ID
  IntColumn get id => integer().autoIncrement()();

  /// 예약 시간
  TextColumn get bookingTime => text()();

  /// 타이머 이름
  TextColumn get timerName => text()();

  /// 생성 일자
  DateTimeColumn get createdAt => dateTime().clientDefault(
        () => DateTime.now().toUtc(),
      )();
}
