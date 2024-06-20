import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:smart_farm/model/timer_model.dart';
import 'package:smart_farm/model/unit_table.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'drift.g.dart';

@DriftDatabase(
  tables: [
    TimerTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

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
