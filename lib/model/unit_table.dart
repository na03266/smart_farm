import 'package:drift/drift.dart';

class UnitTable extends Table {
  /// primary
  IntColumn get id => integer().autoIncrement()();

  /// 유닛 이름
  TextColumn get unitName => text().nullable()();

  /// 유닛 번호
  IntColumn get unitNumber => integer().nullable()();

  ///타이머
  IntColumn get timerId => integer().nullable()();

  /// 유닛 현재 상태(켜짐 꺼짐)
  BoolColumn get isOn => boolean().withDefault(const Constant(false))();

  /// 유닛 모드(자동:true 수동:false)
  /// false 경우만 시간 설정이 적용 되도록.
  BoolColumn get isAuto => boolean().withDefault(const Constant(false))();

  ///갱신 시간
  DateTimeColumn get updatedAt => dateTime().nullable()();
}
