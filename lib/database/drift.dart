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
// Read: 특정 기간 동안의 센서 데이터 가져오기
// Read: 특정 기간 동안의 센서 데이터 가져오기
  Future<List<SensorDataTableData>> getSensorDataFromLastDay(DateTime date) async {

    final todayMidnight = DateTime(date.year, date.month, date.day);
    final tomorrowMidnight = todayMidnight.add(Duration(days: 1));

    final query = select(sensorDataTable)
      ..where((tbl) => tbl.createdAt.isBetweenValues(todayMidnight, tomorrowMidnight))
      ..orderBy([(t) => OrderingTerm(expression: t.createdAt)]);

    final sensorData = await query.get();

    List<SensorDataTableData> averagedData = [];

    for (int i = 0; i < 49; i++) {
      // 48 intervals of 30 minutes in a day
      final start = todayMidnight.add(Duration(minutes: i * 30));
      final end = start.add(Duration(minutes: 30));

      final intervalData = sensorData
          .where((data) =>
              data.createdAt.isAfter(start) && data.createdAt.isBefore(end))
          .toList();

      if (intervalData.isNotEmpty) {
        final averageTemperature = intervalData
                .map((data) => data.temperature)
                .reduce((a, b) => a + b) /
            intervalData.length;
        final averageHumidity =
            intervalData.map((data) => data.humidity).reduce((a, b) => a + b) /
                intervalData.length;
        final averagePressure =
            intervalData.map((data) => data.pressure).reduce((a, b) => a + b) /
                intervalData.length;
        final averageLightIntensity = intervalData
                .map((data) => data.lightIntensity)
                .reduce((a, b) => a + b) /
            intervalData.length;
        final averageCo2 =
            intervalData.map((data) => data.co2).reduce((a, b) => a + b) /
                intervalData.length;
        final averagePh =
            intervalData.map((data) => data.ph).reduce((a, b) => a + b) /
                intervalData.length;
        final averageSoilTemperature = intervalData
                .map((data) => data.soilTemperature)
                .reduce((a, b) => a + b) /
            intervalData.length;
        final averageSoilMoisture = intervalData
                .map((data) => data.soilMoisture)
                .reduce((a, b) => a + b) /
            intervalData.length;
        final averageElectricalConductivity = intervalData
                .map((data) => data.electricalConductivity)
                .reduce((a, b) => a + b) /
            intervalData.length;

        averagedData.add(SensorDataTableData(
          id: intervalData.first.id,
          // Assuming you want to use the ID from one of the entries
          temperature: averageTemperature,
          humidity: averageHumidity,
          pressure: averagePressure,
          lightIntensity: averageLightIntensity,
          co2: averageCo2,
          ph: averagePh,
          soilTemperature: averageSoilTemperature,
          soilMoisture: averageSoilMoisture,
          electricalConductivity: averageElectricalConductivity,
          createdAt: start,
        ));
      }else {
        // 데이터가 없는 경우에도 null 값으로 추가
        averagedData.add(SensorDataTableData(
          id: i, // 또는 적절한 기본값
          temperature: 0,
          humidity: 0,
          pressure: 0,
          lightIntensity: 0,
          co2: 0,
          ph: 0,
          soilTemperature: 0,
          soilMoisture: 0,
          electricalConductivity: 0,
          createdAt: start,
        ));
      }
    }

    return averagedData;
  }

  // Read: 가장 최근 센서 데이터 가져오기
  Future<SensorDataTableData?> getLatestSensorData() => (select(sensorDataTable)
        ..orderBy([
          (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)
        ])
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
