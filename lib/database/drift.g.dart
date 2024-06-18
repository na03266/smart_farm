// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift.dart';

// ignore_for_file: type=lint
class $UnitTableTable extends UnitTable
    with TableInfo<$UnitTableTable, UnitTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UnitTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unitNumberMeta =
      const VerificationMeta('unitNumber');
  @override
  late final GeneratedColumn<int> unitNumber = GeneratedColumn<int>(
      'unit_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<bool> status = GeneratedColumn<bool>(
      'status', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("status" IN (0, 1))'));
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<bool> mode = GeneratedColumn<bool>(
      'mode', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("mode" IN (0, 1))'));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, unitNumber, status, mode, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'unit_table';
  @override
  VerificationContext validateIntegrity(Insertable<UnitTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('unit_number')) {
      context.handle(
          _unitNumberMeta,
          unitNumber.isAcceptableOrUnknown(
              data['unit_number']!, _unitNumberMeta));
    } else if (isInserting) {
      context.missing(_unitNumberMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
          _modeMeta, mode.isAcceptableOrUnknown(data['mode']!, _modeMeta));
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UnitTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UnitTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      unitNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unit_number'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}status'])!,
      mode: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}mode'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UnitTableTable createAlias(String alias) {
    return $UnitTableTable(attachedDatabase, alias);
  }
}

class UnitTableData extends DataClass implements Insertable<UnitTableData> {
  /// primary
  final int id;

  /// 유닛 이름
  final String name;

  /// 유닛 번호
  final int unitNumber;

  /// 유닛 상태(켜짐 꺼짐)
  final bool status;

  /// 유닛 모드(자동:false 수동:true)
  /// false 경우만 시간 설정이 적용 되도록.
  final bool mode;

  ///갱신 시간
  final DateTime updatedAt;
  const UnitTableData(
      {required this.id,
      required this.name,
      required this.unitNumber,
      required this.status,
      required this.mode,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['unit_number'] = Variable<int>(unitNumber);
    map['status'] = Variable<bool>(status);
    map['mode'] = Variable<bool>(mode);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UnitTableCompanion toCompanion(bool nullToAbsent) {
    return UnitTableCompanion(
      id: Value(id),
      name: Value(name),
      unitNumber: Value(unitNumber),
      status: Value(status),
      mode: Value(mode),
      updatedAt: Value(updatedAt),
    );
  }

  factory UnitTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UnitTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      unitNumber: serializer.fromJson<int>(json['unitNumber']),
      status: serializer.fromJson<bool>(json['status']),
      mode: serializer.fromJson<bool>(json['mode']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'unitNumber': serializer.toJson<int>(unitNumber),
      'status': serializer.toJson<bool>(status),
      'mode': serializer.toJson<bool>(mode),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UnitTableData copyWith(
          {int? id,
          String? name,
          int? unitNumber,
          bool? status,
          bool? mode,
          DateTime? updatedAt}) =>
      UnitTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        unitNumber: unitNumber ?? this.unitNumber,
        status: status ?? this.status,
        mode: mode ?? this.mode,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('UnitTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('unitNumber: $unitNumber, ')
          ..write('status: $status, ')
          ..write('mode: $mode, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, unitNumber, status, mode, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UnitTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.unitNumber == this.unitNumber &&
          other.status == this.status &&
          other.mode == this.mode &&
          other.updatedAt == this.updatedAt);
}

class UnitTableCompanion extends UpdateCompanion<UnitTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> unitNumber;
  final Value<bool> status;
  final Value<bool> mode;
  final Value<DateTime> updatedAt;
  const UnitTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.unitNumber = const Value.absent(),
    this.status = const Value.absent(),
    this.mode = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UnitTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int unitNumber,
    required bool status,
    required bool mode,
    required DateTime updatedAt,
  })  : name = Value(name),
        unitNumber = Value(unitNumber),
        status = Value(status),
        mode = Value(mode),
        updatedAt = Value(updatedAt);
  static Insertable<UnitTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? unitNumber,
    Expression<bool>? status,
    Expression<bool>? mode,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (unitNumber != null) 'unit_number': unitNumber,
      if (status != null) 'status': status,
      if (mode != null) 'mode': mode,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UnitTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? unitNumber,
      Value<bool>? status,
      Value<bool>? mode,
      Value<DateTime>? updatedAt}) {
    return UnitTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      unitNumber: unitNumber ?? this.unitNumber,
      status: status ?? this.status,
      mode: mode ?? this.mode,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (unitNumber.present) {
      map['unit_number'] = Variable<int>(unitNumber.value);
    }
    if (status.present) {
      map['status'] = Variable<bool>(status.value);
    }
    if (mode.present) {
      map['mode'] = Variable<bool>(mode.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UnitTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('unitNumber: $unitNumber, ')
          ..write('status: $status, ')
          ..write('mode: $mode, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $UnitTableTable unitTable = $UnitTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [unitTable];
}

typedef $$UnitTableTableInsertCompanionBuilder = UnitTableCompanion Function({
  Value<int> id,
  required String name,
  required int unitNumber,
  required bool status,
  required bool mode,
  required DateTime updatedAt,
});
typedef $$UnitTableTableUpdateCompanionBuilder = UnitTableCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> unitNumber,
  Value<bool> status,
  Value<bool> mode,
  Value<DateTime> updatedAt,
});

class $$UnitTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UnitTableTable,
    UnitTableData,
    $$UnitTableTableFilterComposer,
    $$UnitTableTableOrderingComposer,
    $$UnitTableTableProcessedTableManager,
    $$UnitTableTableInsertCompanionBuilder,
    $$UnitTableTableUpdateCompanionBuilder> {
  $$UnitTableTableTableManager(_$AppDatabase db, $UnitTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UnitTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UnitTableTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$UnitTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> unitNumber = const Value.absent(),
            Value<bool> status = const Value.absent(),
            Value<bool> mode = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UnitTableCompanion(
            id: id,
            name: name,
            unitNumber: unitNumber,
            status: status,
            mode: mode,
            updatedAt: updatedAt,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String name,
            required int unitNumber,
            required bool status,
            required bool mode,
            required DateTime updatedAt,
          }) =>
              UnitTableCompanion.insert(
            id: id,
            name: name,
            unitNumber: unitNumber,
            status: status,
            mode: mode,
            updatedAt: updatedAt,
          ),
        ));
}

class $$UnitTableTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $UnitTableTable,
    UnitTableData,
    $$UnitTableTableFilterComposer,
    $$UnitTableTableOrderingComposer,
    $$UnitTableTableProcessedTableManager,
    $$UnitTableTableInsertCompanionBuilder,
    $$UnitTableTableUpdateCompanionBuilder> {
  $$UnitTableTableProcessedTableManager(super.$state);
}

class $$UnitTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $UnitTableTable> {
  $$UnitTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get unitNumber => $state.composableBuilder(
      column: $state.table.unitNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get mode => $state.composableBuilder(
      column: $state.table.mode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$UnitTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $UnitTableTable> {
  $$UnitTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get unitNumber => $state.composableBuilder(
      column: $state.table.unitNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get mode => $state.composableBuilder(
      column: $state.table.mode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$UnitTableTableTableManager get unitTable =>
      $$UnitTableTableTableManager(_db, _db.unitTable);
}
