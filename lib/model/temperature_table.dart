
import 'package:drift/drift.dart';

class TemperatureTable extends Table{
  /// 식별 가능한 아이디
  IntColumn get id => integer().autoIncrement()();

  /// 시간
  TextColumn get time => text()();
  /// 최고 온도
  RealColumn get highTemp => real()();
  /// 최저 온도
  RealColumn get lowTemp => real()();
  /// 업데이트 시간
  DateTimeColumn get updatedAt => dateTime().nullable()();
}