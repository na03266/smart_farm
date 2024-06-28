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
  static const VerificationMeta _bookingTimeMeta =
      const VerificationMeta('bookingTime');
  @override
  late final GeneratedColumn<String> bookingTime = GeneratedColumn<String>(
      'booking_time', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timerNameMeta =
      const VerificationMeta('timerName');
  @override
  late final GeneratedColumn<String> timerName = GeneratedColumn<String>(
      'timer_name', aliasedName, false,
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
  List<GeneratedColumn> get $columns => [id, bookingTime, timerName, createdAt];
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
    if (data.containsKey('booking_time')) {
      context.handle(
          _bookingTimeMeta,
          bookingTime.isAcceptableOrUnknown(
              data['booking_time']!, _bookingTimeMeta));
    } else if (isInserting) {
      context.missing(_bookingTimeMeta);
    }
    if (data.containsKey('timer_name')) {
      context.handle(_timerNameMeta,
          timerName.isAcceptableOrUnknown(data['timer_name']!, _timerNameMeta));
    } else if (isInserting) {
      context.missing(_timerNameMeta);
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
      bookingTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}booking_time'])!,
      timerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timer_name'])!,
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

  /// 예약 시간
  final String bookingTime;

  /// 타이머 이름
  final String timerName;

  /// 생성 일자
  final DateTime createdAt;
  const TimerTableData(
      {required this.id,
      required this.bookingTime,
      required this.timerName,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['booking_time'] = Variable<String>(bookingTime);
    map['timer_name'] = Variable<String>(timerName);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TimerTableCompanion toCompanion(bool nullToAbsent) {
    return TimerTableCompanion(
      id: Value(id),
      bookingTime: Value(bookingTime),
      timerName: Value(timerName),
      createdAt: Value(createdAt),
    );
  }

  factory TimerTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimerTableData(
      id: serializer.fromJson<int>(json['id']),
      bookingTime: serializer.fromJson<String>(json['bookingTime']),
      timerName: serializer.fromJson<String>(json['timerName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookingTime': serializer.toJson<String>(bookingTime),
      'timerName': serializer.toJson<String>(timerName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TimerTableData copyWith(
          {int? id,
          String? bookingTime,
          String? timerName,
          DateTime? createdAt}) =>
      TimerTableData(
        id: id ?? this.id,
        bookingTime: bookingTime ?? this.bookingTime,
        timerName: timerName ?? this.timerName,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('TimerTableData(')
          ..write('id: $id, ')
          ..write('bookingTime: $bookingTime, ')
          ..write('timerName: $timerName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bookingTime, timerName, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimerTableData &&
          other.id == this.id &&
          other.bookingTime == this.bookingTime &&
          other.timerName == this.timerName &&
          other.createdAt == this.createdAt);
}

class TimerTableCompanion extends UpdateCompanion<TimerTableData> {
  final Value<int> id;
  final Value<String> bookingTime;
  final Value<String> timerName;
  final Value<DateTime> createdAt;
  const TimerTableCompanion({
    this.id = const Value.absent(),
    this.bookingTime = const Value.absent(),
    this.timerName = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TimerTableCompanion.insert({
    this.id = const Value.absent(),
    required String bookingTime,
    required String timerName,
    this.createdAt = const Value.absent(),
  })  : bookingTime = Value(bookingTime),
        timerName = Value(timerName);
  static Insertable<TimerTableData> custom({
    Expression<int>? id,
    Expression<String>? bookingTime,
    Expression<String>? timerName,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookingTime != null) 'booking_time': bookingTime,
      if (timerName != null) 'timer_name': timerName,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TimerTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? bookingTime,
      Value<String>? timerName,
      Value<DateTime>? createdAt}) {
    return TimerTableCompanion(
      id: id ?? this.id,
      bookingTime: bookingTime ?? this.bookingTime,
      timerName: timerName ?? this.timerName,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookingTime.present) {
      map['booking_time'] = Variable<String>(bookingTime.value);
    }
    if (timerName.present) {
      map['timer_name'] = Variable<String>(timerName.value);
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
          ..write('bookingTime: $bookingTime, ')
          ..write('timerName: $timerName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

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
  static const VerificationMeta _unitNameMeta =
      const VerificationMeta('unitName');
  @override
  late final GeneratedColumn<String> unitName = GeneratedColumn<String>(
      'unit_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unitNumberMeta =
      const VerificationMeta('unitNumber');
  @override
  late final GeneratedColumn<int> unitNumber = GeneratedColumn<int>(
      'unit_number', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _timerIdMeta =
      const VerificationMeta('timerId');
  @override
  late final GeneratedColumn<int> timerId = GeneratedColumn<int>(
      'timer_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isOnMeta = const VerificationMeta('isOn');
  @override
  late final GeneratedColumn<bool> isOn = GeneratedColumn<bool>(
      'is_on', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_on" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isAutoMeta = const VerificationMeta('isAuto');
  @override
  late final GeneratedColumn<bool> isAuto = GeneratedColumn<bool>(
      'is_auto', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_auto" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, unitName, unitNumber, timerId, isOn, isAuto, updatedAt];
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
    if (data.containsKey('unit_name')) {
      context.handle(_unitNameMeta,
          unitName.isAcceptableOrUnknown(data['unit_name']!, _unitNameMeta));
    }
    if (data.containsKey('unit_number')) {
      context.handle(
          _unitNumberMeta,
          unitNumber.isAcceptableOrUnknown(
              data['unit_number']!, _unitNumberMeta));
    }
    if (data.containsKey('timer_id')) {
      context.handle(_timerIdMeta,
          timerId.isAcceptableOrUnknown(data['timer_id']!, _timerIdMeta));
    }
    if (data.containsKey('is_on')) {
      context.handle(
          _isOnMeta, isOn.isAcceptableOrUnknown(data['is_on']!, _isOnMeta));
    }
    if (data.containsKey('is_auto')) {
      context.handle(_isAutoMeta,
          isAuto.isAcceptableOrUnknown(data['is_auto']!, _isAutoMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
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
      unitName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit_name']),
      unitNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unit_number']),
      timerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}timer_id']),
      isOn: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_on'])!,
      isAuto: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_auto'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
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
  final String? unitName;

  /// 유닛 번호
  final int? unitNumber;

  ///타이머
  final int? timerId;

  /// 유닛 현재 상태(켜짐 꺼짐)
  final bool isOn;

  /// 유닛 모드(자동:true 수동:false)
  /// false 경우만 시간 설정이 적용 되도록.
  final bool isAuto;

  ///갱신 시간
  final DateTime? updatedAt;
  const UnitTableData(
      {required this.id,
      this.unitName,
      this.unitNumber,
      this.timerId,
      required this.isOn,
      required this.isAuto,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || unitName != null) {
      map['unit_name'] = Variable<String>(unitName);
    }
    if (!nullToAbsent || unitNumber != null) {
      map['unit_number'] = Variable<int>(unitNumber);
    }
    if (!nullToAbsent || timerId != null) {
      map['timer_id'] = Variable<int>(timerId);
    }
    map['is_on'] = Variable<bool>(isOn);
    map['is_auto'] = Variable<bool>(isAuto);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  UnitTableCompanion toCompanion(bool nullToAbsent) {
    return UnitTableCompanion(
      id: Value(id),
      unitName: unitName == null && nullToAbsent
          ? const Value.absent()
          : Value(unitName),
      unitNumber: unitNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(unitNumber),
      timerId: timerId == null && nullToAbsent
          ? const Value.absent()
          : Value(timerId),
      isOn: Value(isOn),
      isAuto: Value(isAuto),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory UnitTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UnitTableData(
      id: serializer.fromJson<int>(json['id']),
      unitName: serializer.fromJson<String?>(json['unitName']),
      unitNumber: serializer.fromJson<int?>(json['unitNumber']),
      timerId: serializer.fromJson<int?>(json['timerId']),
      isOn: serializer.fromJson<bool>(json['isOn']),
      isAuto: serializer.fromJson<bool>(json['isAuto']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'unitName': serializer.toJson<String?>(unitName),
      'unitNumber': serializer.toJson<int?>(unitNumber),
      'timerId': serializer.toJson<int?>(timerId),
      'isOn': serializer.toJson<bool>(isOn),
      'isAuto': serializer.toJson<bool>(isAuto),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  UnitTableData copyWith(
          {int? id,
          Value<String?> unitName = const Value.absent(),
          Value<int?> unitNumber = const Value.absent(),
          Value<int?> timerId = const Value.absent(),
          bool? isOn,
          bool? isAuto,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      UnitTableData(
        id: id ?? this.id,
        unitName: unitName.present ? unitName.value : this.unitName,
        unitNumber: unitNumber.present ? unitNumber.value : this.unitNumber,
        timerId: timerId.present ? timerId.value : this.timerId,
        isOn: isOn ?? this.isOn,
        isAuto: isAuto ?? this.isAuto,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('UnitTableData(')
          ..write('id: $id, ')
          ..write('unitName: $unitName, ')
          ..write('unitNumber: $unitNumber, ')
          ..write('timerId: $timerId, ')
          ..write('isOn: $isOn, ')
          ..write('isAuto: $isAuto, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, unitName, unitNumber, timerId, isOn, isAuto, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UnitTableData &&
          other.id == this.id &&
          other.unitName == this.unitName &&
          other.unitNumber == this.unitNumber &&
          other.timerId == this.timerId &&
          other.isOn == this.isOn &&
          other.isAuto == this.isAuto &&
          other.updatedAt == this.updatedAt);
}

class UnitTableCompanion extends UpdateCompanion<UnitTableData> {
  final Value<int> id;
  final Value<String?> unitName;
  final Value<int?> unitNumber;
  final Value<int?> timerId;
  final Value<bool> isOn;
  final Value<bool> isAuto;
  final Value<DateTime?> updatedAt;
  const UnitTableCompanion({
    this.id = const Value.absent(),
    this.unitName = const Value.absent(),
    this.unitNumber = const Value.absent(),
    this.timerId = const Value.absent(),
    this.isOn = const Value.absent(),
    this.isAuto = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UnitTableCompanion.insert({
    this.id = const Value.absent(),
    this.unitName = const Value.absent(),
    this.unitNumber = const Value.absent(),
    this.timerId = const Value.absent(),
    this.isOn = const Value.absent(),
    this.isAuto = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<UnitTableData> custom({
    Expression<int>? id,
    Expression<String>? unitName,
    Expression<int>? unitNumber,
    Expression<int>? timerId,
    Expression<bool>? isOn,
    Expression<bool>? isAuto,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (unitName != null) 'unit_name': unitName,
      if (unitNumber != null) 'unit_number': unitNumber,
      if (timerId != null) 'timer_id': timerId,
      if (isOn != null) 'is_on': isOn,
      if (isAuto != null) 'is_auto': isAuto,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UnitTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? unitName,
      Value<int?>? unitNumber,
      Value<int?>? timerId,
      Value<bool>? isOn,
      Value<bool>? isAuto,
      Value<DateTime?>? updatedAt}) {
    return UnitTableCompanion(
      id: id ?? this.id,
      unitName: unitName ?? this.unitName,
      unitNumber: unitNumber ?? this.unitNumber,
      timerId: timerId ?? this.timerId,
      isOn: isOn ?? this.isOn,
      isAuto: isAuto ?? this.isAuto,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (unitName.present) {
      map['unit_name'] = Variable<String>(unitName.value);
    }
    if (unitNumber.present) {
      map['unit_number'] = Variable<int>(unitNumber.value);
    }
    if (timerId.present) {
      map['timer_id'] = Variable<int>(timerId.value);
    }
    if (isOn.present) {
      map['is_on'] = Variable<bool>(isOn.value);
    }
    if (isAuto.present) {
      map['is_auto'] = Variable<bool>(isAuto.value);
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
          ..write('unitName: $unitName, ')
          ..write('unitNumber: $unitNumber, ')
          ..write('timerId: $timerId, ')
          ..write('isOn: $isOn, ')
          ..write('isAuto: $isAuto, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $TimerTableTable timerTable = $TimerTableTable(this);
  late final $UnitTableTable unitTable = $UnitTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [timerTable, unitTable];
}

typedef $$TimerTableTableInsertCompanionBuilder = TimerTableCompanion Function({
  Value<int> id,
  required String bookingTime,
  required String timerName,
  Value<DateTime> createdAt,
});
typedef $$TimerTableTableUpdateCompanionBuilder = TimerTableCompanion Function({
  Value<int> id,
  Value<String> bookingTime,
  Value<String> timerName,
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
            Value<String> bookingTime = const Value.absent(),
            Value<String> timerName = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              TimerTableCompanion(
            id: id,
            bookingTime: bookingTime,
            timerName: timerName,
            createdAt: createdAt,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String bookingTime,
            required String timerName,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              TimerTableCompanion.insert(
            id: id,
            bookingTime: bookingTime,
            timerName: timerName,
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

  ColumnFilters<String> get bookingTime => $state.composableBuilder(
      column: $state.table.bookingTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get timerName => $state.composableBuilder(
      column: $state.table.timerName,
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

  ColumnOrderings<String> get bookingTime => $state.composableBuilder(
      column: $state.table.bookingTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get timerName => $state.composableBuilder(
      column: $state.table.timerName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$UnitTableTableInsertCompanionBuilder = UnitTableCompanion Function({
  Value<int> id,
  Value<String?> unitName,
  Value<int?> unitNumber,
  Value<int?> timerId,
  Value<bool> isOn,
  Value<bool> isAuto,
  Value<DateTime?> updatedAt,
});
typedef $$UnitTableTableUpdateCompanionBuilder = UnitTableCompanion Function({
  Value<int> id,
  Value<String?> unitName,
  Value<int?> unitNumber,
  Value<int?> timerId,
  Value<bool> isOn,
  Value<bool> isAuto,
  Value<DateTime?> updatedAt,
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
            Value<String?> unitName = const Value.absent(),
            Value<int?> unitNumber = const Value.absent(),
            Value<int?> timerId = const Value.absent(),
            Value<bool> isOn = const Value.absent(),
            Value<bool> isAuto = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              UnitTableCompanion(
            id: id,
            unitName: unitName,
            unitNumber: unitNumber,
            timerId: timerId,
            isOn: isOn,
            isAuto: isAuto,
            updatedAt: updatedAt,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String?> unitName = const Value.absent(),
            Value<int?> unitNumber = const Value.absent(),
            Value<int?> timerId = const Value.absent(),
            Value<bool> isOn = const Value.absent(),
            Value<bool> isAuto = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              UnitTableCompanion.insert(
            id: id,
            unitName: unitName,
            unitNumber: unitNumber,
            timerId: timerId,
            isOn: isOn,
            isAuto: isAuto,
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

  ColumnFilters<String> get unitName => $state.composableBuilder(
      column: $state.table.unitName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get unitNumber => $state.composableBuilder(
      column: $state.table.unitNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get timerId => $state.composableBuilder(
      column: $state.table.timerId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isOn => $state.composableBuilder(
      column: $state.table.isOn,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isAuto => $state.composableBuilder(
      column: $state.table.isAuto,
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

  ColumnOrderings<String> get unitName => $state.composableBuilder(
      column: $state.table.unitName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get unitNumber => $state.composableBuilder(
      column: $state.table.unitNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get timerId => $state.composableBuilder(
      column: $state.table.timerId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isOn => $state.composableBuilder(
      column: $state.table.isOn,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isAuto => $state.composableBuilder(
      column: $state.table.isAuto,
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
  $$TimerTableTableTableManager get timerTable =>
      $$TimerTableTableTableManager(_db, _db.timerTable);
  $$UnitTableTableTableManager get unitTable =>
      $$UnitTableTableTableManager(_db, _db.unitTable);
}
