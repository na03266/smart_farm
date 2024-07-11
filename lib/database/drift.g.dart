// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift.dart';

// ignore_for_file: type=lint
class $SensorDataTableTable extends SensorDataTable
    with TableInfo<$SensorDataTableTable, SensorDataTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SensorDataTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _temperatureMeta =
      const VerificationMeta('temperature');
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
      'temperature', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _humidityMeta =
      const VerificationMeta('humidity');
  @override
  late final GeneratedColumn<double> humidity = GeneratedColumn<double>(
      'humidity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _pressureMeta =
      const VerificationMeta('pressure');
  @override
  late final GeneratedColumn<double> pressure = GeneratedColumn<double>(
      'pressure', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _lightIntensityMeta =
      const VerificationMeta('lightIntensity');
  @override
  late final GeneratedColumn<double> lightIntensity = GeneratedColumn<double>(
      'light_intensity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _co2Meta = const VerificationMeta('co2');
  @override
  late final GeneratedColumn<double> co2 = GeneratedColumn<double>(
      'co2', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _phMeta = const VerificationMeta('ph');
  @override
  late final GeneratedColumn<double> ph = GeneratedColumn<double>(
      'ph', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _soilTemperatureMeta =
      const VerificationMeta('soilTemperature');
  @override
  late final GeneratedColumn<double> soilTemperature = GeneratedColumn<double>(
      'soil_temperature', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _soilMoistureMeta =
      const VerificationMeta('soilMoisture');
  @override
  late final GeneratedColumn<double> soilMoisture = GeneratedColumn<double>(
      'soil_moisture', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _electricalConductivityMeta =
      const VerificationMeta('electricalConductivity');
  @override
  late final GeneratedColumn<double> electricalConductivity =
      GeneratedColumn<double>('electrical_conductivity', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc());
  @override
  List<GeneratedColumn> get $columns => [
        id,
        temperature,
        humidity,
        pressure,
        lightIntensity,
        co2,
        ph,
        soilTemperature,
        soilMoisture,
        electricalConductivity,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sensor_data_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<SensorDataTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('temperature')) {
      context.handle(
          _temperatureMeta,
          temperature.isAcceptableOrUnknown(
              data['temperature']!, _temperatureMeta));
    } else if (isInserting) {
      context.missing(_temperatureMeta);
    }
    if (data.containsKey('humidity')) {
      context.handle(_humidityMeta,
          humidity.isAcceptableOrUnknown(data['humidity']!, _humidityMeta));
    } else if (isInserting) {
      context.missing(_humidityMeta);
    }
    if (data.containsKey('pressure')) {
      context.handle(_pressureMeta,
          pressure.isAcceptableOrUnknown(data['pressure']!, _pressureMeta));
    } else if (isInserting) {
      context.missing(_pressureMeta);
    }
    if (data.containsKey('light_intensity')) {
      context.handle(
          _lightIntensityMeta,
          lightIntensity.isAcceptableOrUnknown(
              data['light_intensity']!, _lightIntensityMeta));
    } else if (isInserting) {
      context.missing(_lightIntensityMeta);
    }
    if (data.containsKey('co2')) {
      context.handle(
          _co2Meta, co2.isAcceptableOrUnknown(data['co2']!, _co2Meta));
    } else if (isInserting) {
      context.missing(_co2Meta);
    }
    if (data.containsKey('ph')) {
      context.handle(_phMeta, ph.isAcceptableOrUnknown(data['ph']!, _phMeta));
    } else if (isInserting) {
      context.missing(_phMeta);
    }
    if (data.containsKey('soil_temperature')) {
      context.handle(
          _soilTemperatureMeta,
          soilTemperature.isAcceptableOrUnknown(
              data['soil_temperature']!, _soilTemperatureMeta));
    } else if (isInserting) {
      context.missing(_soilTemperatureMeta);
    }
    if (data.containsKey('soil_moisture')) {
      context.handle(
          _soilMoistureMeta,
          soilMoisture.isAcceptableOrUnknown(
              data['soil_moisture']!, _soilMoistureMeta));
    } else if (isInserting) {
      context.missing(_soilMoistureMeta);
    }
    if (data.containsKey('electrical_conductivity')) {
      context.handle(
          _electricalConductivityMeta,
          electricalConductivity.isAcceptableOrUnknown(
              data['electrical_conductivity']!, _electricalConductivityMeta));
    } else if (isInserting) {
      context.missing(_electricalConductivityMeta);
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
  SensorDataTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SensorDataTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      temperature: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}temperature'])!,
      humidity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}humidity'])!,
      pressure: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}pressure'])!,
      lightIntensity: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}light_intensity'])!,
      co2: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}co2'])!,
      ph: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}ph'])!,
      soilTemperature: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}soil_temperature'])!,
      soilMoisture: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}soil_moisture'])!,
      electricalConductivity: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}electrical_conductivity'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SensorDataTableTable createAlias(String alias) {
    return $SensorDataTableTable(attachedDatabase, alias);
  }
}

class SensorDataTableData extends DataClass
    implements Insertable<SensorDataTableData> {
  /// 식별 가능한 ID
  final int id;

  /// 온도
  final double temperature;

  /// 습도
  final double humidity;

  /// 대기압
  final double pressure;

  /// 조도
  final double lightIntensity;

  /// 이산화탄소
  final double co2;

  /// ph 산성도
  final double ph;

  /// 토양 온도
  final double soilTemperature;

  /// 토양 습도
  final double soilMoisture;

  /// 전기 전도도 ec
  final double electricalConductivity;

  /// 생성 일자
  final DateTime createdAt;
  const SensorDataTableData(
      {required this.id,
      required this.temperature,
      required this.humidity,
      required this.pressure,
      required this.lightIntensity,
      required this.co2,
      required this.ph,
      required this.soilTemperature,
      required this.soilMoisture,
      required this.electricalConductivity,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['temperature'] = Variable<double>(temperature);
    map['humidity'] = Variable<double>(humidity);
    map['pressure'] = Variable<double>(pressure);
    map['light_intensity'] = Variable<double>(lightIntensity);
    map['co2'] = Variable<double>(co2);
    map['ph'] = Variable<double>(ph);
    map['soil_temperature'] = Variable<double>(soilTemperature);
    map['soil_moisture'] = Variable<double>(soilMoisture);
    map['electrical_conductivity'] = Variable<double>(electricalConductivity);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SensorDataTableCompanion toCompanion(bool nullToAbsent) {
    return SensorDataTableCompanion(
      id: Value(id),
      temperature: Value(temperature),
      humidity: Value(humidity),
      pressure: Value(pressure),
      lightIntensity: Value(lightIntensity),
      co2: Value(co2),
      ph: Value(ph),
      soilTemperature: Value(soilTemperature),
      soilMoisture: Value(soilMoisture),
      electricalConductivity: Value(electricalConductivity),
      createdAt: Value(createdAt),
    );
  }

  factory SensorDataTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SensorDataTableData(
      id: serializer.fromJson<int>(json['id']),
      temperature: serializer.fromJson<double>(json['temperature']),
      humidity: serializer.fromJson<double>(json['humidity']),
      pressure: serializer.fromJson<double>(json['pressure']),
      lightIntensity: serializer.fromJson<double>(json['lightIntensity']),
      co2: serializer.fromJson<double>(json['co2']),
      ph: serializer.fromJson<double>(json['ph']),
      soilTemperature: serializer.fromJson<double>(json['soilTemperature']),
      soilMoisture: serializer.fromJson<double>(json['soilMoisture']),
      electricalConductivity:
          serializer.fromJson<double>(json['electricalConductivity']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'temperature': serializer.toJson<double>(temperature),
      'humidity': serializer.toJson<double>(humidity),
      'pressure': serializer.toJson<double>(pressure),
      'lightIntensity': serializer.toJson<double>(lightIntensity),
      'co2': serializer.toJson<double>(co2),
      'ph': serializer.toJson<double>(ph),
      'soilTemperature': serializer.toJson<double>(soilTemperature),
      'soilMoisture': serializer.toJson<double>(soilMoisture),
      'electricalConductivity':
          serializer.toJson<double>(electricalConductivity),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SensorDataTableData copyWith(
          {int? id,
          double? temperature,
          double? humidity,
          double? pressure,
          double? lightIntensity,
          double? co2,
          double? ph,
          double? soilTemperature,
          double? soilMoisture,
          double? electricalConductivity,
          DateTime? createdAt}) =>
      SensorDataTableData(
        id: id ?? this.id,
        temperature: temperature ?? this.temperature,
        humidity: humidity ?? this.humidity,
        pressure: pressure ?? this.pressure,
        lightIntensity: lightIntensity ?? this.lightIntensity,
        co2: co2 ?? this.co2,
        ph: ph ?? this.ph,
        soilTemperature: soilTemperature ?? this.soilTemperature,
        soilMoisture: soilMoisture ?? this.soilMoisture,
        electricalConductivity:
            electricalConductivity ?? this.electricalConductivity,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('SensorDataTableData(')
          ..write('id: $id, ')
          ..write('temperature: $temperature, ')
          ..write('humidity: $humidity, ')
          ..write('pressure: $pressure, ')
          ..write('lightIntensity: $lightIntensity, ')
          ..write('co2: $co2, ')
          ..write('ph: $ph, ')
          ..write('soilTemperature: $soilTemperature, ')
          ..write('soilMoisture: $soilMoisture, ')
          ..write('electricalConductivity: $electricalConductivity, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      temperature,
      humidity,
      pressure,
      lightIntensity,
      co2,
      ph,
      soilTemperature,
      soilMoisture,
      electricalConductivity,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SensorDataTableData &&
          other.id == this.id &&
          other.temperature == this.temperature &&
          other.humidity == this.humidity &&
          other.pressure == this.pressure &&
          other.lightIntensity == this.lightIntensity &&
          other.co2 == this.co2 &&
          other.ph == this.ph &&
          other.soilTemperature == this.soilTemperature &&
          other.soilMoisture == this.soilMoisture &&
          other.electricalConductivity == this.electricalConductivity &&
          other.createdAt == this.createdAt);
}

class SensorDataTableCompanion extends UpdateCompanion<SensorDataTableData> {
  final Value<int> id;
  final Value<double> temperature;
  final Value<double> humidity;
  final Value<double> pressure;
  final Value<double> lightIntensity;
  final Value<double> co2;
  final Value<double> ph;
  final Value<double> soilTemperature;
  final Value<double> soilMoisture;
  final Value<double> electricalConductivity;
  final Value<DateTime> createdAt;
  const SensorDataTableCompanion({
    this.id = const Value.absent(),
    this.temperature = const Value.absent(),
    this.humidity = const Value.absent(),
    this.pressure = const Value.absent(),
    this.lightIntensity = const Value.absent(),
    this.co2 = const Value.absent(),
    this.ph = const Value.absent(),
    this.soilTemperature = const Value.absent(),
    this.soilMoisture = const Value.absent(),
    this.electricalConductivity = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SensorDataTableCompanion.insert({
    this.id = const Value.absent(),
    required double temperature,
    required double humidity,
    required double pressure,
    required double lightIntensity,
    required double co2,
    required double ph,
    required double soilTemperature,
    required double soilMoisture,
    required double electricalConductivity,
    this.createdAt = const Value.absent(),
  })  : temperature = Value(temperature),
        humidity = Value(humidity),
        pressure = Value(pressure),
        lightIntensity = Value(lightIntensity),
        co2 = Value(co2),
        ph = Value(ph),
        soilTemperature = Value(soilTemperature),
        soilMoisture = Value(soilMoisture),
        electricalConductivity = Value(electricalConductivity);
  static Insertable<SensorDataTableData> custom({
    Expression<int>? id,
    Expression<double>? temperature,
    Expression<double>? humidity,
    Expression<double>? pressure,
    Expression<double>? lightIntensity,
    Expression<double>? co2,
    Expression<double>? ph,
    Expression<double>? soilTemperature,
    Expression<double>? soilMoisture,
    Expression<double>? electricalConductivity,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (temperature != null) 'temperature': temperature,
      if (humidity != null) 'humidity': humidity,
      if (pressure != null) 'pressure': pressure,
      if (lightIntensity != null) 'light_intensity': lightIntensity,
      if (co2 != null) 'co2': co2,
      if (ph != null) 'ph': ph,
      if (soilTemperature != null) 'soil_temperature': soilTemperature,
      if (soilMoisture != null) 'soil_moisture': soilMoisture,
      if (electricalConductivity != null)
        'electrical_conductivity': electricalConductivity,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SensorDataTableCompanion copyWith(
      {Value<int>? id,
      Value<double>? temperature,
      Value<double>? humidity,
      Value<double>? pressure,
      Value<double>? lightIntensity,
      Value<double>? co2,
      Value<double>? ph,
      Value<double>? soilTemperature,
      Value<double>? soilMoisture,
      Value<double>? electricalConductivity,
      Value<DateTime>? createdAt}) {
    return SensorDataTableCompanion(
      id: id ?? this.id,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
      pressure: pressure ?? this.pressure,
      lightIntensity: lightIntensity ?? this.lightIntensity,
      co2: co2 ?? this.co2,
      ph: ph ?? this.ph,
      soilTemperature: soilTemperature ?? this.soilTemperature,
      soilMoisture: soilMoisture ?? this.soilMoisture,
      electricalConductivity:
          electricalConductivity ?? this.electricalConductivity,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (humidity.present) {
      map['humidity'] = Variable<double>(humidity.value);
    }
    if (pressure.present) {
      map['pressure'] = Variable<double>(pressure.value);
    }
    if (lightIntensity.present) {
      map['light_intensity'] = Variable<double>(lightIntensity.value);
    }
    if (co2.present) {
      map['co2'] = Variable<double>(co2.value);
    }
    if (ph.present) {
      map['ph'] = Variable<double>(ph.value);
    }
    if (soilTemperature.present) {
      map['soil_temperature'] = Variable<double>(soilTemperature.value);
    }
    if (soilMoisture.present) {
      map['soil_moisture'] = Variable<double>(soilMoisture.value);
    }
    if (electricalConductivity.present) {
      map['electrical_conductivity'] =
          Variable<double>(electricalConductivity.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SensorDataTableCompanion(')
          ..write('id: $id, ')
          ..write('temperature: $temperature, ')
          ..write('humidity: $humidity, ')
          ..write('pressure: $pressure, ')
          ..write('lightIntensity: $lightIntensity, ')
          ..write('co2: $co2, ')
          ..write('ph: $ph, ')
          ..write('soilTemperature: $soilTemperature, ')
          ..write('soilMoisture: $soilMoisture, ')
          ..write('electricalConductivity: $electricalConductivity, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $SensorDataTableTable sensorDataTable =
      $SensorDataTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [sensorDataTable];
}

typedef $$SensorDataTableTableInsertCompanionBuilder = SensorDataTableCompanion
    Function({
  Value<int> id,
  required double temperature,
  required double humidity,
  required double pressure,
  required double lightIntensity,
  required double co2,
  required double ph,
  required double soilTemperature,
  required double soilMoisture,
  required double electricalConductivity,
  Value<DateTime> createdAt,
});
typedef $$SensorDataTableTableUpdateCompanionBuilder = SensorDataTableCompanion
    Function({
  Value<int> id,
  Value<double> temperature,
  Value<double> humidity,
  Value<double> pressure,
  Value<double> lightIntensity,
  Value<double> co2,
  Value<double> ph,
  Value<double> soilTemperature,
  Value<double> soilMoisture,
  Value<double> electricalConductivity,
  Value<DateTime> createdAt,
});

class $$SensorDataTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SensorDataTableTable,
    SensorDataTableData,
    $$SensorDataTableTableFilterComposer,
    $$SensorDataTableTableOrderingComposer,
    $$SensorDataTableTableProcessedTableManager,
    $$SensorDataTableTableInsertCompanionBuilder,
    $$SensorDataTableTableUpdateCompanionBuilder> {
  $$SensorDataTableTableTableManager(
      _$AppDatabase db, $SensorDataTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SensorDataTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SensorDataTableTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$SensorDataTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<double> temperature = const Value.absent(),
            Value<double> humidity = const Value.absent(),
            Value<double> pressure = const Value.absent(),
            Value<double> lightIntensity = const Value.absent(),
            Value<double> co2 = const Value.absent(),
            Value<double> ph = const Value.absent(),
            Value<double> soilTemperature = const Value.absent(),
            Value<double> soilMoisture = const Value.absent(),
            Value<double> electricalConductivity = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SensorDataTableCompanion(
            id: id,
            temperature: temperature,
            humidity: humidity,
            pressure: pressure,
            lightIntensity: lightIntensity,
            co2: co2,
            ph: ph,
            soilTemperature: soilTemperature,
            soilMoisture: soilMoisture,
            electricalConductivity: electricalConductivity,
            createdAt: createdAt,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required double temperature,
            required double humidity,
            required double pressure,
            required double lightIntensity,
            required double co2,
            required double ph,
            required double soilTemperature,
            required double soilMoisture,
            required double electricalConductivity,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SensorDataTableCompanion.insert(
            id: id,
            temperature: temperature,
            humidity: humidity,
            pressure: pressure,
            lightIntensity: lightIntensity,
            co2: co2,
            ph: ph,
            soilTemperature: soilTemperature,
            soilMoisture: soilMoisture,
            electricalConductivity: electricalConductivity,
            createdAt: createdAt,
          ),
        ));
}

class $$SensorDataTableTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $SensorDataTableTable,
    SensorDataTableData,
    $$SensorDataTableTableFilterComposer,
    $$SensorDataTableTableOrderingComposer,
    $$SensorDataTableTableProcessedTableManager,
    $$SensorDataTableTableInsertCompanionBuilder,
    $$SensorDataTableTableUpdateCompanionBuilder> {
  $$SensorDataTableTableProcessedTableManager(super.$state);
}

class $$SensorDataTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SensorDataTableTable> {
  $$SensorDataTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get temperature => $state.composableBuilder(
      column: $state.table.temperature,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get humidity => $state.composableBuilder(
      column: $state.table.humidity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get pressure => $state.composableBuilder(
      column: $state.table.pressure,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get lightIntensity => $state.composableBuilder(
      column: $state.table.lightIntensity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get co2 => $state.composableBuilder(
      column: $state.table.co2,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get ph => $state.composableBuilder(
      column: $state.table.ph,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get soilTemperature => $state.composableBuilder(
      column: $state.table.soilTemperature,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get soilMoisture => $state.composableBuilder(
      column: $state.table.soilMoisture,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get electricalConductivity => $state.composableBuilder(
      column: $state.table.electricalConductivity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SensorDataTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SensorDataTableTable> {
  $$SensorDataTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get temperature => $state.composableBuilder(
      column: $state.table.temperature,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get humidity => $state.composableBuilder(
      column: $state.table.humidity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get pressure => $state.composableBuilder(
      column: $state.table.pressure,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get lightIntensity => $state.composableBuilder(
      column: $state.table.lightIntensity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get co2 => $state.composableBuilder(
      column: $state.table.co2,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get ph => $state.composableBuilder(
      column: $state.table.ph,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get soilTemperature => $state.composableBuilder(
      column: $state.table.soilTemperature,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get soilMoisture => $state.composableBuilder(
      column: $state.table.soilMoisture,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get electricalConductivity =>
      $state.composableBuilder(
          column: $state.table.electricalConductivity,
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
  $$SensorDataTableTableTableManager get sensorDataTable =>
      $$SensorDataTableTableTableManager(_db, _db.sensorDataTable);
}
