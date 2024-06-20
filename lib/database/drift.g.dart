// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift.dart';

// ignore_for_file: type=lint
class $TimerTableTable extends TimerTable
    with TableInfo<$TimerTableTable, TimerTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimerTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _timerNameMeta =
      const VerificationMeta('timerName');
  @override
  late final GeneratedColumn<String> timerName = GeneratedColumn<String>(
      'timer_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _activatedUnitMeta =
      const VerificationMeta('activatedUnit');
  @override
  late final GeneratedColumn<String> activatedUnit = GeneratedColumn<String>(
      'activated_unit', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  @override
  List<GeneratedColumn> get $columns =>
      [id, startTime, endTime, timerName, activatedUnit, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'timer_table';
  @override
  VerificationContext validateIntegrity(Insertable<TimerTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('timer_name')) {
      context.handle(_timerNameMeta,
          timerName.isAcceptableOrUnknown(data['timer_name']!, _timerNameMeta));
    } else if (isInserting) {
      context.missing(_timerNameMeta);
    }
    if (data.containsKey('activated_unit')) {
      context.handle(
          _activatedUnitMeta,
          activatedUnit.isAcceptableOrUnknown(
              data['activated_unit']!, _activatedUnitMeta));
    } else if (isInserting) {
      context.missing(_activatedUnitMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimerTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimerTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time'])!,
      timerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timer_name'])!,
      activatedUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}activated_unit'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $TimerTableTable createAlias(String alias) {
    return $TimerTableTable(attachedDatabase, alias);
  }
}

class TimerTableData extends DataClass implements Insertable<TimerTableData> {
  /// 식별 가능한 ID
  final int id;

  /// 시작 시간
  final DateTime startTime;

  /// 종료 시간
  final DateTime endTime;

  /// 타이머 이름
  final String timerName;

  /// 할당된 유닛
  /// 2진수 16자리
  final String activatedUnit;

  /// 생성일자
  final DateTime createdAt;
  const TimerTableData(
      {required this.id,
      required this.startTime,
      required this.endTime,
      required this.timerName,
      required this.activatedUnit,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    map['timer_name'] = Variable<String>(timerName);
    map['activated_unit'] = Variable<String>(activatedUnit);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TimerTableCompanion toCompanion(bool nullToAbsent) {
    return TimerTableCompanion(
      id: Value(id),
      startTime: Value(startTime),
      endTime: Value(endTime),
      timerName: Value(timerName),
      activatedUnit: Value(activatedUnit),
      createdAt: Value(createdAt),
    );
  }

  factory TimerTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimerTableData(
      id: serializer.fromJson<int>(json['id']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      timerName: serializer.fromJson<String>(json['timerName']),
      activatedUnit: serializer.fromJson<String>(json['activatedUnit']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'timerName': serializer.toJson<String>(timerName),
      'activatedUnit': serializer.toJson<String>(activatedUnit),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TimerTableData copyWith(
          {int? id,
          DateTime? startTime,
          DateTime? endTime,
          String? timerName,
          String? activatedUnit,
          DateTime? createdAt}) =>
      TimerTableData(
        id: id ?? this.id,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        timerName: timerName ?? this.timerName,
        activatedUnit: activatedUnit ?? this.activatedUnit,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('TimerTableData(')
          ..write('id: $id, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('timerName: $timerName, ')
          ..write('activatedUnit: $activatedUnit, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, startTime, endTime, timerName, activatedUnit, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimerTableData &&
          other.id == this.id &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.timerName == this.timerName &&
          other.activatedUnit == this.activatedUnit &&
          other.createdAt == this.createdAt);
}

class TimerTableCompanion extends UpdateCompanion<TimerTableData> {
  final Value<int> id;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<String> timerName;
  final Value<String> activatedUnit;
  final Value<DateTime> createdAt;
  const TimerTableCompanion({
    this.id = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.timerName = const Value.absent(),
    this.activatedUnit = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TimerTableCompanion.insert({
    this.id = const Value.absent(),
    required DateTime startTime,
    required DateTime endTime,
    required String timerName,
    required String activatedUnit,
    this.createdAt = const Value.absent(),
  })  : startTime = Value(startTime),
        endTime = Value(endTime),
        timerName = Value(timerName),
        activatedUnit = Value(activatedUnit);
  static Insertable<TimerTableData> custom({
    Expression<int>? id,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? timerName,
    Expression<String>? activatedUnit,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (timerName != null) 'timer_name': timerName,
      if (activatedUnit != null) 'activated_unit': activatedUnit,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TimerTableCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? startTime,
      Value<DateTime>? endTime,
      Value<String>? timerName,
      Value<String>? activatedUnit,
      Value<DateTime>? createdAt}) {
    return TimerTableCompanion(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      timerName: timerName ?? this.timerName,
      activatedUnit: activatedUnit ?? this.activatedUnit,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (timerName.present) {
      map['timer_name'] = Variable<String>(timerName.value);
    }
    if (activatedUnit.present) {
      map['activated_unit'] = Variable<String>(activatedUnit.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimerTableCompanion(')
          ..write('id: $id, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('timerName: $timerName, ')
          ..write('activatedUnit: $activatedUnit, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $TimerTableTable timerTable = $TimerTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [timerTable];
}

typedef $$TimerTableTableInsertCompanionBuilder = TimerTableCompanion Function({
  Value<int> id,
  required DateTime startTime,
  required DateTime endTime,
  required String timerName,
  required String activatedUnit,
  Value<DateTime> createdAt,
});
typedef $$TimerTableTableUpdateCompanionBuilder = TimerTableCompanion Function({
  Value<int> id,
  Value<DateTime> startTime,
  Value<DateTime> endTime,
  Value<String> timerName,
  Value<String> activatedUnit,
  Value<DateTime> createdAt,
});

class $$TimerTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TimerTableTable,
    TimerTableData,
    $$TimerTableTableFilterComposer,
    $$TimerTableTableOrderingComposer,
    $$TimerTableTableProcessedTableManager,
    $$TimerTableTableInsertCompanionBuilder,
    $$TimerTableTableUpdateCompanionBuilder> {
  $$TimerTableTableTableManager(_$AppDatabase db, $TimerTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TimerTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TimerTableTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$TimerTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime> endTime = const Value.absent(),
            Value<String> timerName = const Value.absent(),
            Value<String> activatedUnit = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              TimerTableCompanion(
            id: id,
            startTime: startTime,
            endTime: endTime,
            timerName: timerName,
            activatedUnit: activatedUnit,
            createdAt: createdAt,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required DateTime startTime,
            required DateTime endTime,
            required String timerName,
            required String activatedUnit,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              TimerTableCompanion.insert(
            id: id,
            startTime: startTime,
            endTime: endTime,
            timerName: timerName,
            activatedUnit: activatedUnit,
            createdAt: createdAt,
          ),
        ));
}

class $$TimerTableTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $TimerTableTable,
    TimerTableData,
    $$TimerTableTableFilterComposer,
    $$TimerTableTableOrderingComposer,
    $$TimerTableTableProcessedTableManager,
    $$TimerTableTableInsertCompanionBuilder,
    $$TimerTableTableUpdateCompanionBuilder> {
  $$TimerTableTableProcessedTableManager(super.$state);
}

class $$TimerTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TimerTableTable> {
  $$TimerTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get startTime => $state.composableBuilder(
      column: $state.table.startTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get endTime => $state.composableBuilder(
      column: $state.table.endTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get timerName => $state.composableBuilder(
      column: $state.table.timerName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get activatedUnit => $state.composableBuilder(
      column: $state.table.activatedUnit,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TimerTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TimerTableTable> {
  $$TimerTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get startTime => $state.composableBuilder(
      column: $state.table.startTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get endTime => $state.composableBuilder(
      column: $state.table.endTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get timerName => $state.composableBuilder(
      column: $state.table.timerName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get activatedUnit => $state.composableBuilder(
      column: $state.table.activatedUnit,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$TimerTableTableTableManager get timerTable =>
      $$TimerTableTableTableManager(_db, _db.timerTable);
}
