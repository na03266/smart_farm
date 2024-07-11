import 'package:drift/drift.dart';

class SensorDataTable extends Table {
  /// 식별 가능한 ID
  IntColumn get id => integer().autoIncrement()();

  /// 온도
  RealColumn get temperature => real()();

  /// 습도
  RealColumn get humidity => real()();

  /// 대기압
  RealColumn get pressure => real()();

  /// 조도
  RealColumn get lightIntensity => real()();

  /// 이산화탄소
  RealColumn get co2 => real()();

  /// ph 산성도
  RealColumn get ph => real()();

  /// 토양 온도
  RealColumn get soilTemperature => real()();

  /// 토양 습도
  RealColumn get soilMoisture => real()();

  /// 전기 전도도 ec
  RealColumn get electricalConductivity => real()();

  /// 생성 일자
  DateTimeColumn get createdAt => dateTime().clientDefault(
        () => DateTime.now().toUtc(),
  )();
}