import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:smart_farm/model/temperature_table.dart';
import 'package:smart_farm/model/timer_table.dart';
import 'package:smart_farm/model/unit_table.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'drift.g.dart';

@DriftDatabase(
  tables: [
    TimerTable,
    UnitTable,
    TemperatureTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          // UnitTable 초기 데이터 삽입
          await into(unitTable).insert(const UnitTableCompanion(
            unitName: Value('LED'),
            unitNumber: Value(1),
          ));
          await into(unitTable).insert(const UnitTableCompanion(
              unitName: Value('차광막'),
              unitNumber: Value(1),
              isAuto: Value(false)));
          for (int i = 0; i < 48; i++) {
            await into(temperatureTable).insert(TemperatureTableCompanion(
              time: Value("${i ~/ 2}:${i % 2 == 1 ? 30 : 00}"),
              highTemp: Value(15.0 + i / 2),
              lowTemp: Value(10.0 + i / 2),
              updatedAt: Value(DateTime.now()),
            ));
          }
        },
      );

  /// 타이머
  Future<int> createTimer(TimerTableCompanion data) =>
      into(timerTable).insert(data);

  Stream<List<TimerTableData>> getTimers() => (select(timerTable)
        ..orderBy([
          (t) => OrderingTerm(
                expression: t.timerName,
                mode: OrderingMode.asc,
              )
        ]))
      .watch();

  Future<TimerTableData> getTimerById(int id) =>
      (select(timerTable)..where((table) => table.id.equals(id))).getSingle();

  Future<int> updateTimerById(int id, TimerTableCompanion data) =>
      (update(timerTable)..where((t) => t.id.equals(id))).write(data);

  Future<int> removeTimer(int id) =>
      (delete(timerTable)..where((table) => table.id.equals(id))).go();

  /// 유닛
  Future<int> createUnit(UnitTableCompanion data) =>
      into(unitTable).insert(data);

  Future<int> updateUnitById(int id, UnitTableCompanion data) =>
      (update(unitTable)..where((t) => t.id.equals(id))).write(data);

  Future<List<UnitTableData>> getUnits() => (select(unitTable)
        ..orderBy([
          (t) => OrderingTerm(
                expression: t.id,
                mode: OrderingMode.asc,
              )
        ]))
      .get();

  /// 온도
  Future<List<TemperatureTableData>> getTemperatures() => (select(temperatureTable)
    ..orderBy([
          (t) => OrderingTerm(
        expression: t.id,
        mode: OrderingMode.asc,
      )
    ]))
      .get();

  Future<int> updateTempById(int id, TemperatureTableCompanion data) =>
      (update(temperatureTable)..where((t) => t.id.equals(id))).write(data);

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
