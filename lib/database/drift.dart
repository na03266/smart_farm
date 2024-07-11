import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:smart_farm/model/sensor_data_table.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'drift.g.dart';

@DriftDatabase(
  tables: [
    SensorDataTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());


  // /// 타이머
  // Future<int> createTimer(TimerTableCompanion data) =>
  //     into(timerTable).insert(data);
  //
  // Stream<List<TimerTableData>> getTimers() => (select(timerTable)
  //       ..orderBy([
  //         (t) => OrderingTerm(
  //               expression: t.timerName,
  //               mode: OrderingMode.asc,
  //             )
  //       ]))
  //     .watch();
  //
  // Future<TimerTableData> getTimerById(int id) =>
  //     (select(timerTable)..where((table) => table.id.equals(id))).getSingle();
  //
  // Future<int> updateTimerById(int id, TimerTableCompanion data) =>
  //     (update(timerTable)..where((t) => t.id.equals(id))).write(data);
  //
  // Future<int> removeTimer(int id) =>
  //     (delete(timerTable)..where((table) => table.id.equals(id))).go();
  //
  // /// 유닛
  // Future<int> createUnit(UnitTableCompanion data) =>
  //     into(unitTable).insert(data);
  //
  // Future<int> updateUnitById(int id, UnitTableCompanion data) =>
  //     (update(unitTable)..where((t) => t.id.equals(id))).write(data);
  //
  // Future<List<UnitTableData>> getUnits() => (select(unitTable)
  //       ..orderBy([
  //         (t) => OrderingTerm(
  //               expression: t.id,
  //               mode: OrderingMode.asc,
  //             )
  //       ]))
  //     .get();
  //
  // /// 온도
  // Future<List<TemperatureTableData>> getTemperatures() => (select(temperatureTable)
  //   ..orderBy([
  //         (t) => OrderingTerm(
  //       expression: t.id,
  //       mode: OrderingMode.asc,
  //     )
  //   ]))
  //     .get();
  //
  // Future<int> updateTempById(int id, TemperatureTableCompanion data) =>
  //     (update(temperatureTable)..where((t) => t.id.equals(id))).write(data);
  // Create: 센서 데이터 추가
  Future<int> insertSensorData(SensorDataTableCompanion data) =>
      into(sensorDataTable).insert(data);

  // Read: 특정 기간 동안의 센서 데이터 가져오기
  Future<List<SensorDataTableData>> getSensorDataFromLastDay() {
    final now = DateTime.now();
    final oneDayAgo = now.subtract(const Duration(days: 1));

    final query = select(sensorDataTable)
      ..where((tbl) => tbl.createdAt.isBetweenValues(oneDayAgo, now))
      ..orderBy([(t) => OrderingTerm(expression: t.createdAt)]);

    return query.get();
  }

  // Read: 가장 최근 센서 데이터 가져오기
  Future<SensorDataTableData?> getLatestSensorData() =>
      (select(sensorDataTable)
        ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)])
        ..limit(1))
          .getSingleOrNull();

  // Update: 특정 ID의 센서 데이터 업데이트
  Future<bool> updateSensorData(SensorDataTableCompanion data) =>
      update(sensorDataTable).replace(data);

  // Delete: 특정 ID의 센서 데이터 삭제
  Future<int> deleteSensorData(int id) =>
      (delete(sensorDataTable)..where((tbl) => tbl.id.equals(id))).go();

  // // Delete: 특정 날짜 이전의 센서 데이터 삭제 (데이터 정리용)
  // Future<int> deleteOldSensorData(DateTime before) =>
  //     (delete(sensorDataTable)..where((tbl) => tbl.createdAt.isSmallerThan(before))).go();

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      /// 앱이 설치된 폴더의 위치를 가져오는 함수
      final dbFolder = await getApplicationDocumentsDirectory();

      /// 파일 주소를 수정해 줌.[설치된 위치 + String]
      final file = File(p.join(dbFolder.path, 'db.sqlite'));

      /// 안드로이드 구 버전일 경우 문제 생기는 것 방지를 위한 코드
      if (Platform.isAndroid) {
        await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      }

      /// 임시 파일을 가져 오는 것.
      final cachebase = await getTemporaryDirectory();

      sqlite3.tempDirectory = cachebase.path;

      return NativeDatabase.createInBackground(file);
    },
  );
}
