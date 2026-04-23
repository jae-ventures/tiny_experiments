// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PactsTable extends Pacts with TableInfo<$PactsTable, Pact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PactCadence, String> cadence =
      GeneratedColumn<String>(
        'cadence',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PactCadence>($PactsTable.$convertercadence);
  static const VerificationMeta _durationTrialsMeta = const VerificationMeta(
    'durationTrials',
  );
  @override
  late final GeneratedColumn<int> durationTrials = GeneratedColumn<int>(
    'duration_trials',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PactStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PactStatus>($PactsTable.$converterstatus);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ifConditionMeta = const VerificationMeta(
    'ifCondition',
  );
  @override
  late final GeneratedColumn<String> ifCondition = GeneratedColumn<String>(
    'if_condition',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _thenActionMeta = const VerificationMeta(
    'thenAction',
  );
  @override
  late final GeneratedColumn<String> thenAction = GeneratedColumn<String>(
    'then_action',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hypothesisMeta = const VerificationMeta(
    'hypothesis',
  );
  @override
  late final GeneratedColumn<String> hypothesis = GeneratedColumn<String>(
    'hypothesis',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CuriosityTemperature?, String>
  temperature = GeneratedColumn<String>(
    'temperature',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<CuriosityTemperature?>($PactsTable.$convertertemperaturen);
  static const VerificationMeta _reflectionIntervalTrialsMeta =
      const VerificationMeta('reflectionIntervalTrials');
  @override
  late final GeneratedColumn<int> reflectionIntervalTrials =
      GeneratedColumn<int>(
        'reflection_interval_trials',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    action,
    cadence,
    durationTrials,
    startDate,
    endDate,
    status,
    createdAt,
    ifCondition,
    thenAction,
    hypothesis,
    temperature,
    reflectionIntervalTrials,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pacts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Pact> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('duration_trials')) {
      context.handle(
        _durationTrialsMeta,
        durationTrials.isAcceptableOrUnknown(
          data['duration_trials']!,
          _durationTrialsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationTrialsMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('if_condition')) {
      context.handle(
        _ifConditionMeta,
        ifCondition.isAcceptableOrUnknown(
          data['if_condition']!,
          _ifConditionMeta,
        ),
      );
    }
    if (data.containsKey('then_action')) {
      context.handle(
        _thenActionMeta,
        thenAction.isAcceptableOrUnknown(data['then_action']!, _thenActionMeta),
      );
    }
    if (data.containsKey('hypothesis')) {
      context.handle(
        _hypothesisMeta,
        hypothesis.isAcceptableOrUnknown(data['hypothesis']!, _hypothesisMeta),
      );
    }
    if (data.containsKey('reflection_interval_trials')) {
      context.handle(
        _reflectionIntervalTrialsMeta,
        reflectionIntervalTrials.isAcceptableOrUnknown(
          data['reflection_interval_trials']!,
          _reflectionIntervalTrialsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pact(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      cadence: $PactsTable.$convertercadence.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}cadence'],
        )!,
      ),
      durationTrials: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_trials'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      )!,
      status: $PactsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      ifCondition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}if_condition'],
      ),
      thenAction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}then_action'],
      ),
      hypothesis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hypothesis'],
      ),
      temperature: $PactsTable.$convertertemperaturen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}temperature'],
        ),
      ),
      reflectionIntervalTrials: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reflection_interval_trials'],
      ),
    );
  }

  @override
  $PactsTable createAlias(String alias) {
    return $PactsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PactCadence, String, String> $convertercadence =
      const EnumNameConverter<PactCadence>(PactCadence.values);
  static JsonTypeConverter2<PactStatus, String, String> $converterstatus =
      const EnumNameConverter<PactStatus>(PactStatus.values);
  static JsonTypeConverter2<CuriosityTemperature, String, String>
  $convertertemperature = const EnumNameConverter<CuriosityTemperature>(
    CuriosityTemperature.values,
  );
  static JsonTypeConverter2<CuriosityTemperature?, String?, String?>
  $convertertemperaturen = JsonTypeConverter2.asNullable($convertertemperature);
}

class Pact extends DataClass implements Insertable<Pact> {
  final String id;
  final String action;
  final PactCadence cadence;
  final int durationTrials;
  final DateTime startDate;
  final DateTime endDate;
  final PactStatus status;
  final DateTime createdAt;
  final String? ifCondition;
  final String? thenAction;
  final String? hypothesis;
  final CuriosityTemperature? temperature;
  final int? reflectionIntervalTrials;
  const Pact({
    required this.id,
    required this.action,
    required this.cadence,
    required this.durationTrials,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    this.ifCondition,
    this.thenAction,
    this.hypothesis,
    this.temperature,
    this.reflectionIntervalTrials,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['action'] = Variable<String>(action);
    {
      map['cadence'] = Variable<String>(
        $PactsTable.$convertercadence.toSql(cadence),
      );
    }
    map['duration_trials'] = Variable<int>(durationTrials);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    {
      map['status'] = Variable<String>(
        $PactsTable.$converterstatus.toSql(status),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || ifCondition != null) {
      map['if_condition'] = Variable<String>(ifCondition);
    }
    if (!nullToAbsent || thenAction != null) {
      map['then_action'] = Variable<String>(thenAction);
    }
    if (!nullToAbsent || hypothesis != null) {
      map['hypothesis'] = Variable<String>(hypothesis);
    }
    if (!nullToAbsent || temperature != null) {
      map['temperature'] = Variable<String>(
        $PactsTable.$convertertemperaturen.toSql(temperature),
      );
    }
    if (!nullToAbsent || reflectionIntervalTrials != null) {
      map['reflection_interval_trials'] = Variable<int>(
        reflectionIntervalTrials,
      );
    }
    return map;
  }

  PactsCompanion toCompanion(bool nullToAbsent) {
    return PactsCompanion(
      id: Value(id),
      action: Value(action),
      cadence: Value(cadence),
      durationTrials: Value(durationTrials),
      startDate: Value(startDate),
      endDate: Value(endDate),
      status: Value(status),
      createdAt: Value(createdAt),
      ifCondition: ifCondition == null && nullToAbsent
          ? const Value.absent()
          : Value(ifCondition),
      thenAction: thenAction == null && nullToAbsent
          ? const Value.absent()
          : Value(thenAction),
      hypothesis: hypothesis == null && nullToAbsent
          ? const Value.absent()
          : Value(hypothesis),
      temperature: temperature == null && nullToAbsent
          ? const Value.absent()
          : Value(temperature),
      reflectionIntervalTrials: reflectionIntervalTrials == null && nullToAbsent
          ? const Value.absent()
          : Value(reflectionIntervalTrials),
    );
  }

  factory Pact.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pact(
      id: serializer.fromJson<String>(json['id']),
      action: serializer.fromJson<String>(json['action']),
      cadence: $PactsTable.$convertercadence.fromJson(
        serializer.fromJson<String>(json['cadence']),
      ),
      durationTrials: serializer.fromJson<int>(json['durationTrials']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      status: $PactsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      ifCondition: serializer.fromJson<String?>(json['ifCondition']),
      thenAction: serializer.fromJson<String?>(json['thenAction']),
      hypothesis: serializer.fromJson<String?>(json['hypothesis']),
      temperature: $PactsTable.$convertertemperaturen.fromJson(
        serializer.fromJson<String?>(json['temperature']),
      ),
      reflectionIntervalTrials: serializer.fromJson<int?>(
        json['reflectionIntervalTrials'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'action': serializer.toJson<String>(action),
      'cadence': serializer.toJson<String>(
        $PactsTable.$convertercadence.toJson(cadence),
      ),
      'durationTrials': serializer.toJson<int>(durationTrials),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'status': serializer.toJson<String>(
        $PactsTable.$converterstatus.toJson(status),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'ifCondition': serializer.toJson<String?>(ifCondition),
      'thenAction': serializer.toJson<String?>(thenAction),
      'hypothesis': serializer.toJson<String?>(hypothesis),
      'temperature': serializer.toJson<String?>(
        $PactsTable.$convertertemperaturen.toJson(temperature),
      ),
      'reflectionIntervalTrials': serializer.toJson<int?>(
        reflectionIntervalTrials,
      ),
    };
  }

  Pact copyWith({
    String? id,
    String? action,
    PactCadence? cadence,
    int? durationTrials,
    DateTime? startDate,
    DateTime? endDate,
    PactStatus? status,
    DateTime? createdAt,
    Value<String?> ifCondition = const Value.absent(),
    Value<String?> thenAction = const Value.absent(),
    Value<String?> hypothesis = const Value.absent(),
    Value<CuriosityTemperature?> temperature = const Value.absent(),
    Value<int?> reflectionIntervalTrials = const Value.absent(),
  }) => Pact(
    id: id ?? this.id,
    action: action ?? this.action,
    cadence: cadence ?? this.cadence,
    durationTrials: durationTrials ?? this.durationTrials,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    ifCondition: ifCondition.present ? ifCondition.value : this.ifCondition,
    thenAction: thenAction.present ? thenAction.value : this.thenAction,
    hypothesis: hypothesis.present ? hypothesis.value : this.hypothesis,
    temperature: temperature.present ? temperature.value : this.temperature,
    reflectionIntervalTrials: reflectionIntervalTrials.present
        ? reflectionIntervalTrials.value
        : this.reflectionIntervalTrials,
  );
  Pact copyWithCompanion(PactsCompanion data) {
    return Pact(
      id: data.id.present ? data.id.value : this.id,
      action: data.action.present ? data.action.value : this.action,
      cadence: data.cadence.present ? data.cadence.value : this.cadence,
      durationTrials: data.durationTrials.present
          ? data.durationTrials.value
          : this.durationTrials,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      ifCondition: data.ifCondition.present
          ? data.ifCondition.value
          : this.ifCondition,
      thenAction: data.thenAction.present
          ? data.thenAction.value
          : this.thenAction,
      hypothesis: data.hypothesis.present
          ? data.hypothesis.value
          : this.hypothesis,
      temperature: data.temperature.present
          ? data.temperature.value
          : this.temperature,
      reflectionIntervalTrials: data.reflectionIntervalTrials.present
          ? data.reflectionIntervalTrials.value
          : this.reflectionIntervalTrials,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pact(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('cadence: $cadence, ')
          ..write('durationTrials: $durationTrials, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('ifCondition: $ifCondition, ')
          ..write('thenAction: $thenAction, ')
          ..write('hypothesis: $hypothesis, ')
          ..write('temperature: $temperature, ')
          ..write('reflectionIntervalTrials: $reflectionIntervalTrials')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    action,
    cadence,
    durationTrials,
    startDate,
    endDate,
    status,
    createdAt,
    ifCondition,
    thenAction,
    hypothesis,
    temperature,
    reflectionIntervalTrials,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pact &&
          other.id == this.id &&
          other.action == this.action &&
          other.cadence == this.cadence &&
          other.durationTrials == this.durationTrials &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.ifCondition == this.ifCondition &&
          other.thenAction == this.thenAction &&
          other.hypothesis == this.hypothesis &&
          other.temperature == this.temperature &&
          other.reflectionIntervalTrials == this.reflectionIntervalTrials);
}

class PactsCompanion extends UpdateCompanion<Pact> {
  final Value<String> id;
  final Value<String> action;
  final Value<PactCadence> cadence;
  final Value<int> durationTrials;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<PactStatus> status;
  final Value<DateTime> createdAt;
  final Value<String?> ifCondition;
  final Value<String?> thenAction;
  final Value<String?> hypothesis;
  final Value<CuriosityTemperature?> temperature;
  final Value<int?> reflectionIntervalTrials;
  final Value<int> rowid;
  const PactsCompanion({
    this.id = const Value.absent(),
    this.action = const Value.absent(),
    this.cadence = const Value.absent(),
    this.durationTrials = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.ifCondition = const Value.absent(),
    this.thenAction = const Value.absent(),
    this.hypothesis = const Value.absent(),
    this.temperature = const Value.absent(),
    this.reflectionIntervalTrials = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PactsCompanion.insert({
    required String id,
    required String action,
    required PactCadence cadence,
    required int durationTrials,
    required DateTime startDate,
    required DateTime endDate,
    required PactStatus status,
    required DateTime createdAt,
    this.ifCondition = const Value.absent(),
    this.thenAction = const Value.absent(),
    this.hypothesis = const Value.absent(),
    this.temperature = const Value.absent(),
    this.reflectionIntervalTrials = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       action = Value(action),
       cadence = Value(cadence),
       durationTrials = Value(durationTrials),
       startDate = Value(startDate),
       endDate = Value(endDate),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<Pact> custom({
    Expression<String>? id,
    Expression<String>? action,
    Expression<String>? cadence,
    Expression<int>? durationTrials,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<String>? ifCondition,
    Expression<String>? thenAction,
    Expression<String>? hypothesis,
    Expression<String>? temperature,
    Expression<int>? reflectionIntervalTrials,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (action != null) 'action': action,
      if (cadence != null) 'cadence': cadence,
      if (durationTrials != null) 'duration_trials': durationTrials,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (ifCondition != null) 'if_condition': ifCondition,
      if (thenAction != null) 'then_action': thenAction,
      if (hypothesis != null) 'hypothesis': hypothesis,
      if (temperature != null) 'temperature': temperature,
      if (reflectionIntervalTrials != null)
        'reflection_interval_trials': reflectionIntervalTrials,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PactsCompanion copyWith({
    Value<String>? id,
    Value<String>? action,
    Value<PactCadence>? cadence,
    Value<int>? durationTrials,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<PactStatus>? status,
    Value<DateTime>? createdAt,
    Value<String?>? ifCondition,
    Value<String?>? thenAction,
    Value<String?>? hypothesis,
    Value<CuriosityTemperature?>? temperature,
    Value<int?>? reflectionIntervalTrials,
    Value<int>? rowid,
  }) {
    return PactsCompanion(
      id: id ?? this.id,
      action: action ?? this.action,
      cadence: cadence ?? this.cadence,
      durationTrials: durationTrials ?? this.durationTrials,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      ifCondition: ifCondition ?? this.ifCondition,
      thenAction: thenAction ?? this.thenAction,
      hypothesis: hypothesis ?? this.hypothesis,
      temperature: temperature ?? this.temperature,
      reflectionIntervalTrials:
          reflectionIntervalTrials ?? this.reflectionIntervalTrials,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (cadence.present) {
      map['cadence'] = Variable<String>(
        $PactsTable.$convertercadence.toSql(cadence.value),
      );
    }
    if (durationTrials.present) {
      map['duration_trials'] = Variable<int>(durationTrials.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $PactsTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (ifCondition.present) {
      map['if_condition'] = Variable<String>(ifCondition.value);
    }
    if (thenAction.present) {
      map['then_action'] = Variable<String>(thenAction.value);
    }
    if (hypothesis.present) {
      map['hypothesis'] = Variable<String>(hypothesis.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<String>(
        $PactsTable.$convertertemperaturen.toSql(temperature.value),
      );
    }
    if (reflectionIntervalTrials.present) {
      map['reflection_interval_trials'] = Variable<int>(
        reflectionIntervalTrials.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PactsCompanion(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('cadence: $cadence, ')
          ..write('durationTrials: $durationTrials, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('ifCondition: $ifCondition, ')
          ..write('thenAction: $thenAction, ')
          ..write('hypothesis: $hypothesis, ')
          ..write('temperature: $temperature, ')
          ..write('reflectionIntervalTrials: $reflectionIntervalTrials, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TrialsTable extends Trials with TableInfo<$TrialsTable, Trial> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrialsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pactIdMeta = const VerificationMeta('pactId');
  @override
  late final GeneratedColumn<String> pactId = GeneratedColumn<String>(
    'pact_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pacts (id)',
    ),
  );
  static const VerificationMeta _sessionNumberMeta = const VerificationMeta(
    'sessionNumber',
  );
  @override
  late final GeneratedColumn<int> sessionNumber = GeneratedColumn<int>(
    'session_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sequenceIndexMeta = const VerificationMeta(
    'sequenceIndex',
  );
  @override
  late final GeneratedColumn<int> sequenceIndex = GeneratedColumn<int>(
    'sequence_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduledDateMeta = const VerificationMeta(
    'scheduledDate',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledDate =
      GeneratedColumn<DateTime>(
        'scheduled_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  late final GeneratedColumnWithTypeConverter<TrialStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TrialStatus>($TrialsTable.$converterstatus);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pactId,
    sessionNumber,
    sequenceIndex,
    scheduledDate,
    status,
    createdAt,
    completedAt,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trials';
  @override
  VerificationContext validateIntegrity(
    Insertable<Trial> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pact_id')) {
      context.handle(
        _pactIdMeta,
        pactId.isAcceptableOrUnknown(data['pact_id']!, _pactIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pactIdMeta);
    }
    if (data.containsKey('session_number')) {
      context.handle(
        _sessionNumberMeta,
        sessionNumber.isAcceptableOrUnknown(
          data['session_number']!,
          _sessionNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionNumberMeta);
    }
    if (data.containsKey('sequence_index')) {
      context.handle(
        _sequenceIndexMeta,
        sequenceIndex.isAcceptableOrUnknown(
          data['sequence_index']!,
          _sequenceIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sequenceIndexMeta);
    }
    if (data.containsKey('scheduled_date')) {
      context.handle(
        _scheduledDateMeta,
        scheduledDate.isAcceptableOrUnknown(
          data['scheduled_date']!,
          _scheduledDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Trial map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Trial(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pactId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pact_id'],
      )!,
      sessionNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_number'],
      )!,
      sequenceIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sequence_index'],
      )!,
      scheduledDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_date'],
      )!,
      status: $TrialsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $TrialsTable createAlias(String alias) {
    return $TrialsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TrialStatus, String, String> $converterstatus =
      const EnumNameConverter<TrialStatus>(TrialStatus.values);
}

class Trial extends DataClass implements Insertable<Trial> {
  final String id;
  final String pactId;
  final int sessionNumber;
  final int sequenceIndex;
  final DateTime scheduledDate;
  final TrialStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? note;
  const Trial({
    required this.id,
    required this.pactId,
    required this.sessionNumber,
    required this.sequenceIndex,
    required this.scheduledDate,
    required this.status,
    required this.createdAt,
    this.completedAt,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pact_id'] = Variable<String>(pactId);
    map['session_number'] = Variable<int>(sessionNumber);
    map['sequence_index'] = Variable<int>(sequenceIndex);
    map['scheduled_date'] = Variable<DateTime>(scheduledDate);
    {
      map['status'] = Variable<String>(
        $TrialsTable.$converterstatus.toSql(status),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  TrialsCompanion toCompanion(bool nullToAbsent) {
    return TrialsCompanion(
      id: Value(id),
      pactId: Value(pactId),
      sessionNumber: Value(sessionNumber),
      sequenceIndex: Value(sequenceIndex),
      scheduledDate: Value(scheduledDate),
      status: Value(status),
      createdAt: Value(createdAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory Trial.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Trial(
      id: serializer.fromJson<String>(json['id']),
      pactId: serializer.fromJson<String>(json['pactId']),
      sessionNumber: serializer.fromJson<int>(json['sessionNumber']),
      sequenceIndex: serializer.fromJson<int>(json['sequenceIndex']),
      scheduledDate: serializer.fromJson<DateTime>(json['scheduledDate']),
      status: $TrialsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pactId': serializer.toJson<String>(pactId),
      'sessionNumber': serializer.toJson<int>(sessionNumber),
      'sequenceIndex': serializer.toJson<int>(sequenceIndex),
      'scheduledDate': serializer.toJson<DateTime>(scheduledDate),
      'status': serializer.toJson<String>(
        $TrialsTable.$converterstatus.toJson(status),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'note': serializer.toJson<String?>(note),
    };
  }

  Trial copyWith({
    String? id,
    String? pactId,
    int? sessionNumber,
    int? sequenceIndex,
    DateTime? scheduledDate,
    TrialStatus? status,
    DateTime? createdAt,
    Value<DateTime?> completedAt = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => Trial(
    id: id ?? this.id,
    pactId: pactId ?? this.pactId,
    sessionNumber: sessionNumber ?? this.sessionNumber,
    sequenceIndex: sequenceIndex ?? this.sequenceIndex,
    scheduledDate: scheduledDate ?? this.scheduledDate,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    note: note.present ? note.value : this.note,
  );
  Trial copyWithCompanion(TrialsCompanion data) {
    return Trial(
      id: data.id.present ? data.id.value : this.id,
      pactId: data.pactId.present ? data.pactId.value : this.pactId,
      sessionNumber: data.sessionNumber.present
          ? data.sessionNumber.value
          : this.sessionNumber,
      sequenceIndex: data.sequenceIndex.present
          ? data.sequenceIndex.value
          : this.sequenceIndex,
      scheduledDate: data.scheduledDate.present
          ? data.scheduledDate.value
          : this.scheduledDate,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Trial(')
          ..write('id: $id, ')
          ..write('pactId: $pactId, ')
          ..write('sessionNumber: $sessionNumber, ')
          ..write('sequenceIndex: $sequenceIndex, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    pactId,
    sessionNumber,
    sequenceIndex,
    scheduledDate,
    status,
    createdAt,
    completedAt,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trial &&
          other.id == this.id &&
          other.pactId == this.pactId &&
          other.sessionNumber == this.sessionNumber &&
          other.sequenceIndex == this.sequenceIndex &&
          other.scheduledDate == this.scheduledDate &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.completedAt == this.completedAt &&
          other.note == this.note);
}

class TrialsCompanion extends UpdateCompanion<Trial> {
  final Value<String> id;
  final Value<String> pactId;
  final Value<int> sessionNumber;
  final Value<int> sequenceIndex;
  final Value<DateTime> scheduledDate;
  final Value<TrialStatus> status;
  final Value<DateTime> createdAt;
  final Value<DateTime?> completedAt;
  final Value<String?> note;
  final Value<int> rowid;
  const TrialsCompanion({
    this.id = const Value.absent(),
    this.pactId = const Value.absent(),
    this.sessionNumber = const Value.absent(),
    this.sequenceIndex = const Value.absent(),
    this.scheduledDate = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrialsCompanion.insert({
    required String id,
    required String pactId,
    required int sessionNumber,
    required int sequenceIndex,
    required DateTime scheduledDate,
    required TrialStatus status,
    required DateTime createdAt,
    this.completedAt = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       pactId = Value(pactId),
       sessionNumber = Value(sessionNumber),
       sequenceIndex = Value(sequenceIndex),
       scheduledDate = Value(scheduledDate),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<Trial> custom({
    Expression<String>? id,
    Expression<String>? pactId,
    Expression<int>? sessionNumber,
    Expression<int>? sequenceIndex,
    Expression<DateTime>? scheduledDate,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? completedAt,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pactId != null) 'pact_id': pactId,
      if (sessionNumber != null) 'session_number': sessionNumber,
      if (sequenceIndex != null) 'sequence_index': sequenceIndex,
      if (scheduledDate != null) 'scheduled_date': scheduledDate,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrialsCompanion copyWith({
    Value<String>? id,
    Value<String>? pactId,
    Value<int>? sessionNumber,
    Value<int>? sequenceIndex,
    Value<DateTime>? scheduledDate,
    Value<TrialStatus>? status,
    Value<DateTime>? createdAt,
    Value<DateTime?>? completedAt,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return TrialsCompanion(
      id: id ?? this.id,
      pactId: pactId ?? this.pactId,
      sessionNumber: sessionNumber ?? this.sessionNumber,
      sequenceIndex: sequenceIndex ?? this.sequenceIndex,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pactId.present) {
      map['pact_id'] = Variable<String>(pactId.value);
    }
    if (sessionNumber.present) {
      map['session_number'] = Variable<int>(sessionNumber.value);
    }
    if (sequenceIndex.present) {
      map['sequence_index'] = Variable<int>(sequenceIndex.value);
    }
    if (scheduledDate.present) {
      map['scheduled_date'] = Variable<DateTime>(scheduledDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $TrialsTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrialsCompanion(')
          ..write('id: $id, ')
          ..write('pactId: $pactId, ')
          ..write('sessionNumber: $sessionNumber, ')
          ..write('sequenceIndex: $sequenceIndex, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReflectionsTable extends Reflections
    with TableInfo<$ReflectionsTable, Reflection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReflectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pactIdMeta = const VerificationMeta('pactId');
  @override
  late final GeneratedColumn<String> pactId = GeneratedColumn<String>(
    'pact_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pacts (id)',
    ),
  );
  static const VerificationMeta _sessionNumberMeta = const VerificationMeta(
    'sessionNumber',
  );
  @override
  late final GeneratedColumn<int> sessionNumber = GeneratedColumn<int>(
    'session_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ReflectionKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ReflectionKind>($ReflectionsTable.$converterkind);
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CuriosityTemperature?, String>
  temperature =
      GeneratedColumn<String>(
        'temperature',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<CuriosityTemperature?>(
        $ReflectionsTable.$convertertemperaturen,
      );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intentionMeta = const VerificationMeta(
    'intention',
  );
  @override
  late final GeneratedColumn<String> intention = GeneratedColumn<String>(
    'intention',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ReflectionDecision?, String>
  decision = GeneratedColumn<String>(
    'decision',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<ReflectionDecision?>($ReflectionsTable.$converterdecisionn);
  static const VerificationMeta _decisionNoteMeta = const VerificationMeta(
    'decisionNote',
  );
  @override
  late final GeneratedColumn<String> decisionNote = GeneratedColumn<String>(
    'decision_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _linkedTrialIdMeta = const VerificationMeta(
    'linkedTrialId',
  );
  @override
  late final GeneratedColumn<String> linkedTrialId = GeneratedColumn<String>(
    'linked_trial_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pactId,
    sessionNumber,
    kind,
    loggedAt,
    createdAt,
    temperature,
    note,
    intention,
    decision,
    decisionNote,
    linkedTrialId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reflections';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reflection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pact_id')) {
      context.handle(
        _pactIdMeta,
        pactId.isAcceptableOrUnknown(data['pact_id']!, _pactIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pactIdMeta);
    }
    if (data.containsKey('session_number')) {
      context.handle(
        _sessionNumberMeta,
        sessionNumber.isAcceptableOrUnknown(
          data['session_number']!,
          _sessionNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionNumberMeta);
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('intention')) {
      context.handle(
        _intentionMeta,
        intention.isAcceptableOrUnknown(data['intention']!, _intentionMeta),
      );
    }
    if (data.containsKey('decision_note')) {
      context.handle(
        _decisionNoteMeta,
        decisionNote.isAcceptableOrUnknown(
          data['decision_note']!,
          _decisionNoteMeta,
        ),
      );
    }
    if (data.containsKey('linked_trial_id')) {
      context.handle(
        _linkedTrialIdMeta,
        linkedTrialId.isAcceptableOrUnknown(
          data['linked_trial_id']!,
          _linkedTrialIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reflection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reflection(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pactId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pact_id'],
      )!,
      sessionNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_number'],
      )!,
      kind: $ReflectionsTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      temperature: $ReflectionsTable.$convertertemperaturen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}temperature'],
        ),
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      intention: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}intention'],
      ),
      decision: $ReflectionsTable.$converterdecisionn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}decision'],
        ),
      ),
      decisionNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decision_note'],
      ),
      linkedTrialId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}linked_trial_id'],
      ),
    );
  }

  @override
  $ReflectionsTable createAlias(String alias) {
    return $ReflectionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ReflectionKind, String, String> $converterkind =
      const EnumNameConverter<ReflectionKind>(ReflectionKind.values);
  static JsonTypeConverter2<CuriosityTemperature, String, String>
  $convertertemperature = const EnumNameConverter<CuriosityTemperature>(
    CuriosityTemperature.values,
  );
  static JsonTypeConverter2<CuriosityTemperature?, String?, String?>
  $convertertemperaturen = JsonTypeConverter2.asNullable($convertertemperature);
  static JsonTypeConverter2<ReflectionDecision, String, String>
  $converterdecision = const EnumNameConverter<ReflectionDecision>(
    ReflectionDecision.values,
  );
  static JsonTypeConverter2<ReflectionDecision?, String?, String?>
  $converterdecisionn = JsonTypeConverter2.asNullable($converterdecision);
}

class Reflection extends DataClass implements Insertable<Reflection> {
  final String id;
  final String pactId;
  final int sessionNumber;
  final ReflectionKind kind;
  final DateTime loggedAt;
  final DateTime createdAt;
  final CuriosityTemperature? temperature;
  final String? note;
  final String? intention;
  final ReflectionDecision? decision;
  final String? decisionNote;
  final String? linkedTrialId;
  const Reflection({
    required this.id,
    required this.pactId,
    required this.sessionNumber,
    required this.kind,
    required this.loggedAt,
    required this.createdAt,
    this.temperature,
    this.note,
    this.intention,
    this.decision,
    this.decisionNote,
    this.linkedTrialId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pact_id'] = Variable<String>(pactId);
    map['session_number'] = Variable<int>(sessionNumber);
    {
      map['kind'] = Variable<String>(
        $ReflectionsTable.$converterkind.toSql(kind),
      );
    }
    map['logged_at'] = Variable<DateTime>(loggedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || temperature != null) {
      map['temperature'] = Variable<String>(
        $ReflectionsTable.$convertertemperaturen.toSql(temperature),
      );
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || intention != null) {
      map['intention'] = Variable<String>(intention);
    }
    if (!nullToAbsent || decision != null) {
      map['decision'] = Variable<String>(
        $ReflectionsTable.$converterdecisionn.toSql(decision),
      );
    }
    if (!nullToAbsent || decisionNote != null) {
      map['decision_note'] = Variable<String>(decisionNote);
    }
    if (!nullToAbsent || linkedTrialId != null) {
      map['linked_trial_id'] = Variable<String>(linkedTrialId);
    }
    return map;
  }

  ReflectionsCompanion toCompanion(bool nullToAbsent) {
    return ReflectionsCompanion(
      id: Value(id),
      pactId: Value(pactId),
      sessionNumber: Value(sessionNumber),
      kind: Value(kind),
      loggedAt: Value(loggedAt),
      createdAt: Value(createdAt),
      temperature: temperature == null && nullToAbsent
          ? const Value.absent()
          : Value(temperature),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      intention: intention == null && nullToAbsent
          ? const Value.absent()
          : Value(intention),
      decision: decision == null && nullToAbsent
          ? const Value.absent()
          : Value(decision),
      decisionNote: decisionNote == null && nullToAbsent
          ? const Value.absent()
          : Value(decisionNote),
      linkedTrialId: linkedTrialId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedTrialId),
    );
  }

  factory Reflection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reflection(
      id: serializer.fromJson<String>(json['id']),
      pactId: serializer.fromJson<String>(json['pactId']),
      sessionNumber: serializer.fromJson<int>(json['sessionNumber']),
      kind: $ReflectionsTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      temperature: $ReflectionsTable.$convertertemperaturen.fromJson(
        serializer.fromJson<String?>(json['temperature']),
      ),
      note: serializer.fromJson<String?>(json['note']),
      intention: serializer.fromJson<String?>(json['intention']),
      decision: $ReflectionsTable.$converterdecisionn.fromJson(
        serializer.fromJson<String?>(json['decision']),
      ),
      decisionNote: serializer.fromJson<String?>(json['decisionNote']),
      linkedTrialId: serializer.fromJson<String?>(json['linkedTrialId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pactId': serializer.toJson<String>(pactId),
      'sessionNumber': serializer.toJson<int>(sessionNumber),
      'kind': serializer.toJson<String>(
        $ReflectionsTable.$converterkind.toJson(kind),
      ),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'temperature': serializer.toJson<String?>(
        $ReflectionsTable.$convertertemperaturen.toJson(temperature),
      ),
      'note': serializer.toJson<String?>(note),
      'intention': serializer.toJson<String?>(intention),
      'decision': serializer.toJson<String?>(
        $ReflectionsTable.$converterdecisionn.toJson(decision),
      ),
      'decisionNote': serializer.toJson<String?>(decisionNote),
      'linkedTrialId': serializer.toJson<String?>(linkedTrialId),
    };
  }

  Reflection copyWith({
    String? id,
    String? pactId,
    int? sessionNumber,
    ReflectionKind? kind,
    DateTime? loggedAt,
    DateTime? createdAt,
    Value<CuriosityTemperature?> temperature = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<String?> intention = const Value.absent(),
    Value<ReflectionDecision?> decision = const Value.absent(),
    Value<String?> decisionNote = const Value.absent(),
    Value<String?> linkedTrialId = const Value.absent(),
  }) => Reflection(
    id: id ?? this.id,
    pactId: pactId ?? this.pactId,
    sessionNumber: sessionNumber ?? this.sessionNumber,
    kind: kind ?? this.kind,
    loggedAt: loggedAt ?? this.loggedAt,
    createdAt: createdAt ?? this.createdAt,
    temperature: temperature.present ? temperature.value : this.temperature,
    note: note.present ? note.value : this.note,
    intention: intention.present ? intention.value : this.intention,
    decision: decision.present ? decision.value : this.decision,
    decisionNote: decisionNote.present ? decisionNote.value : this.decisionNote,
    linkedTrialId: linkedTrialId.present
        ? linkedTrialId.value
        : this.linkedTrialId,
  );
  Reflection copyWithCompanion(ReflectionsCompanion data) {
    return Reflection(
      id: data.id.present ? data.id.value : this.id,
      pactId: data.pactId.present ? data.pactId.value : this.pactId,
      sessionNumber: data.sessionNumber.present
          ? data.sessionNumber.value
          : this.sessionNumber,
      kind: data.kind.present ? data.kind.value : this.kind,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      temperature: data.temperature.present
          ? data.temperature.value
          : this.temperature,
      note: data.note.present ? data.note.value : this.note,
      intention: data.intention.present ? data.intention.value : this.intention,
      decision: data.decision.present ? data.decision.value : this.decision,
      decisionNote: data.decisionNote.present
          ? data.decisionNote.value
          : this.decisionNote,
      linkedTrialId: data.linkedTrialId.present
          ? data.linkedTrialId.value
          : this.linkedTrialId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reflection(')
          ..write('id: $id, ')
          ..write('pactId: $pactId, ')
          ..write('sessionNumber: $sessionNumber, ')
          ..write('kind: $kind, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('temperature: $temperature, ')
          ..write('note: $note, ')
          ..write('intention: $intention, ')
          ..write('decision: $decision, ')
          ..write('decisionNote: $decisionNote, ')
          ..write('linkedTrialId: $linkedTrialId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    pactId,
    sessionNumber,
    kind,
    loggedAt,
    createdAt,
    temperature,
    note,
    intention,
    decision,
    decisionNote,
    linkedTrialId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reflection &&
          other.id == this.id &&
          other.pactId == this.pactId &&
          other.sessionNumber == this.sessionNumber &&
          other.kind == this.kind &&
          other.loggedAt == this.loggedAt &&
          other.createdAt == this.createdAt &&
          other.temperature == this.temperature &&
          other.note == this.note &&
          other.intention == this.intention &&
          other.decision == this.decision &&
          other.decisionNote == this.decisionNote &&
          other.linkedTrialId == this.linkedTrialId);
}

class ReflectionsCompanion extends UpdateCompanion<Reflection> {
  final Value<String> id;
  final Value<String> pactId;
  final Value<int> sessionNumber;
  final Value<ReflectionKind> kind;
  final Value<DateTime> loggedAt;
  final Value<DateTime> createdAt;
  final Value<CuriosityTemperature?> temperature;
  final Value<String?> note;
  final Value<String?> intention;
  final Value<ReflectionDecision?> decision;
  final Value<String?> decisionNote;
  final Value<String?> linkedTrialId;
  final Value<int> rowid;
  const ReflectionsCompanion({
    this.id = const Value.absent(),
    this.pactId = const Value.absent(),
    this.sessionNumber = const Value.absent(),
    this.kind = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.temperature = const Value.absent(),
    this.note = const Value.absent(),
    this.intention = const Value.absent(),
    this.decision = const Value.absent(),
    this.decisionNote = const Value.absent(),
    this.linkedTrialId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReflectionsCompanion.insert({
    required String id,
    required String pactId,
    required int sessionNumber,
    required ReflectionKind kind,
    required DateTime loggedAt,
    required DateTime createdAt,
    this.temperature = const Value.absent(),
    this.note = const Value.absent(),
    this.intention = const Value.absent(),
    this.decision = const Value.absent(),
    this.decisionNote = const Value.absent(),
    this.linkedTrialId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       pactId = Value(pactId),
       sessionNumber = Value(sessionNumber),
       kind = Value(kind),
       loggedAt = Value(loggedAt),
       createdAt = Value(createdAt);
  static Insertable<Reflection> custom({
    Expression<String>? id,
    Expression<String>? pactId,
    Expression<int>? sessionNumber,
    Expression<String>? kind,
    Expression<DateTime>? loggedAt,
    Expression<DateTime>? createdAt,
    Expression<String>? temperature,
    Expression<String>? note,
    Expression<String>? intention,
    Expression<String>? decision,
    Expression<String>? decisionNote,
    Expression<String>? linkedTrialId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pactId != null) 'pact_id': pactId,
      if (sessionNumber != null) 'session_number': sessionNumber,
      if (kind != null) 'kind': kind,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (temperature != null) 'temperature': temperature,
      if (note != null) 'note': note,
      if (intention != null) 'intention': intention,
      if (decision != null) 'decision': decision,
      if (decisionNote != null) 'decision_note': decisionNote,
      if (linkedTrialId != null) 'linked_trial_id': linkedTrialId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReflectionsCompanion copyWith({
    Value<String>? id,
    Value<String>? pactId,
    Value<int>? sessionNumber,
    Value<ReflectionKind>? kind,
    Value<DateTime>? loggedAt,
    Value<DateTime>? createdAt,
    Value<CuriosityTemperature?>? temperature,
    Value<String?>? note,
    Value<String?>? intention,
    Value<ReflectionDecision?>? decision,
    Value<String?>? decisionNote,
    Value<String?>? linkedTrialId,
    Value<int>? rowid,
  }) {
    return ReflectionsCompanion(
      id: id ?? this.id,
      pactId: pactId ?? this.pactId,
      sessionNumber: sessionNumber ?? this.sessionNumber,
      kind: kind ?? this.kind,
      loggedAt: loggedAt ?? this.loggedAt,
      createdAt: createdAt ?? this.createdAt,
      temperature: temperature ?? this.temperature,
      note: note ?? this.note,
      intention: intention ?? this.intention,
      decision: decision ?? this.decision,
      decisionNote: decisionNote ?? this.decisionNote,
      linkedTrialId: linkedTrialId ?? this.linkedTrialId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pactId.present) {
      map['pact_id'] = Variable<String>(pactId.value);
    }
    if (sessionNumber.present) {
      map['session_number'] = Variable<int>(sessionNumber.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $ReflectionsTable.$converterkind.toSql(kind.value),
      );
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<String>(
        $ReflectionsTable.$convertertemperaturen.toSql(temperature.value),
      );
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (intention.present) {
      map['intention'] = Variable<String>(intention.value);
    }
    if (decision.present) {
      map['decision'] = Variable<String>(
        $ReflectionsTable.$converterdecisionn.toSql(decision.value),
      );
    }
    if (decisionNote.present) {
      map['decision_note'] = Variable<String>(decisionNote.value);
    }
    if (linkedTrialId.present) {
      map['linked_trial_id'] = Variable<String>(linkedTrialId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReflectionsCompanion(')
          ..write('id: $id, ')
          ..write('pactId: $pactId, ')
          ..write('sessionNumber: $sessionNumber, ')
          ..write('kind: $kind, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('temperature: $temperature, ')
          ..write('note: $note, ')
          ..write('intention: $intention, ')
          ..write('decision: $decision, ')
          ..write('decisionNote: $decisionNote, ')
          ..write('linkedTrialId: $linkedTrialId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PactsTable pacts = $PactsTable(this);
  late final $TrialsTable trials = $TrialsTable(this);
  late final $ReflectionsTable reflections = $ReflectionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    pacts,
    trials,
    reflections,
  ];
}

typedef $$PactsTableCreateCompanionBuilder =
    PactsCompanion Function({
      required String id,
      required String action,
      required PactCadence cadence,
      required int durationTrials,
      required DateTime startDate,
      required DateTime endDate,
      required PactStatus status,
      required DateTime createdAt,
      Value<String?> ifCondition,
      Value<String?> thenAction,
      Value<String?> hypothesis,
      Value<CuriosityTemperature?> temperature,
      Value<int?> reflectionIntervalTrials,
      Value<int> rowid,
    });
typedef $$PactsTableUpdateCompanionBuilder =
    PactsCompanion Function({
      Value<String> id,
      Value<String> action,
      Value<PactCadence> cadence,
      Value<int> durationTrials,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<PactStatus> status,
      Value<DateTime> createdAt,
      Value<String?> ifCondition,
      Value<String?> thenAction,
      Value<String?> hypothesis,
      Value<CuriosityTemperature?> temperature,
      Value<int?> reflectionIntervalTrials,
      Value<int> rowid,
    });

final class $$PactsTableReferences
    extends BaseReferences<_$AppDatabase, $PactsTable, Pact> {
  $$PactsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TrialsTable, List<Trial>> _trialsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.trials,
    aliasName: $_aliasNameGenerator(db.pacts.id, db.trials.pactId),
  );

  $$TrialsTableProcessedTableManager get trialsRefs {
    final manager = $$TrialsTableTableManager(
      $_db,
      $_db.trials,
    ).filter((f) => f.pactId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_trialsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReflectionsTable, List<Reflection>>
  _reflectionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reflections,
    aliasName: $_aliasNameGenerator(db.pacts.id, db.reflections.pactId),
  );

  $$ReflectionsTableProcessedTableManager get reflectionsRefs {
    final manager = $$ReflectionsTableTableManager(
      $_db,
      $_db.reflections,
    ).filter((f) => f.pactId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_reflectionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PactsTableFilterComposer extends Composer<_$AppDatabase, $PactsTable> {
  $$PactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PactCadence, PactCadence, String>
  get cadence => $composableBuilder(
    column: $table.cadence,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get durationTrials => $composableBuilder(
    column: $table.durationTrials,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PactStatus, PactStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ifCondition => $composableBuilder(
    column: $table.ifCondition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thenAction => $composableBuilder(
    column: $table.thenAction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hypothesis => $composableBuilder(
    column: $table.hypothesis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    CuriosityTemperature?,
    CuriosityTemperature,
    String
  >
  get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get reflectionIntervalTrials => $composableBuilder(
    column: $table.reflectionIntervalTrials,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> trialsRefs(
    Expression<bool> Function($$TrialsTableFilterComposer f) f,
  ) {
    final $$TrialsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trials,
      getReferencedColumn: (t) => t.pactId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrialsTableFilterComposer(
            $db: $db,
            $table: $db.trials,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> reflectionsRefs(
    Expression<bool> Function($$ReflectionsTableFilterComposer f) f,
  ) {
    final $$ReflectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reflections,
      getReferencedColumn: (t) => t.pactId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReflectionsTableFilterComposer(
            $db: $db,
            $table: $db.reflections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PactsTableOrderingComposer
    extends Composer<_$AppDatabase, $PactsTable> {
  $$PactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cadence => $composableBuilder(
    column: $table.cadence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationTrials => $composableBuilder(
    column: $table.durationTrials,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ifCondition => $composableBuilder(
    column: $table.ifCondition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thenAction => $composableBuilder(
    column: $table.thenAction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hypothesis => $composableBuilder(
    column: $table.hypothesis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reflectionIntervalTrials => $composableBuilder(
    column: $table.reflectionIntervalTrials,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PactsTable> {
  $$PactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PactCadence, String> get cadence =>
      $composableBuilder(column: $table.cadence, builder: (column) => column);

  GeneratedColumn<int> get durationTrials => $composableBuilder(
    column: $table.durationTrials,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PactStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get ifCondition => $composableBuilder(
    column: $table.ifCondition,
    builder: (column) => column,
  );

  GeneratedColumn<String> get thenAction => $composableBuilder(
    column: $table.thenAction,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hypothesis => $composableBuilder(
    column: $table.hypothesis,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<CuriosityTemperature?, String>
  get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reflectionIntervalTrials => $composableBuilder(
    column: $table.reflectionIntervalTrials,
    builder: (column) => column,
  );

  Expression<T> trialsRefs<T extends Object>(
    Expression<T> Function($$TrialsTableAnnotationComposer a) f,
  ) {
    final $$TrialsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trials,
      getReferencedColumn: (t) => t.pactId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrialsTableAnnotationComposer(
            $db: $db,
            $table: $db.trials,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> reflectionsRefs<T extends Object>(
    Expression<T> Function($$ReflectionsTableAnnotationComposer a) f,
  ) {
    final $$ReflectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reflections,
      getReferencedColumn: (t) => t.pactId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReflectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.reflections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PactsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PactsTable,
          Pact,
          $$PactsTableFilterComposer,
          $$PactsTableOrderingComposer,
          $$PactsTableAnnotationComposer,
          $$PactsTableCreateCompanionBuilder,
          $$PactsTableUpdateCompanionBuilder,
          (Pact, $$PactsTableReferences),
          Pact,
          PrefetchHooks Function({bool trialsRefs, bool reflectionsRefs})
        > {
  $$PactsTableTableManager(_$AppDatabase db, $PactsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<PactCadence> cadence = const Value.absent(),
                Value<int> durationTrials = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<PactStatus> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> ifCondition = const Value.absent(),
                Value<String?> thenAction = const Value.absent(),
                Value<String?> hypothesis = const Value.absent(),
                Value<CuriosityTemperature?> temperature = const Value.absent(),
                Value<int?> reflectionIntervalTrials = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PactsCompanion(
                id: id,
                action: action,
                cadence: cadence,
                durationTrials: durationTrials,
                startDate: startDate,
                endDate: endDate,
                status: status,
                createdAt: createdAt,
                ifCondition: ifCondition,
                thenAction: thenAction,
                hypothesis: hypothesis,
                temperature: temperature,
                reflectionIntervalTrials: reflectionIntervalTrials,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String action,
                required PactCadence cadence,
                required int durationTrials,
                required DateTime startDate,
                required DateTime endDate,
                required PactStatus status,
                required DateTime createdAt,
                Value<String?> ifCondition = const Value.absent(),
                Value<String?> thenAction = const Value.absent(),
                Value<String?> hypothesis = const Value.absent(),
                Value<CuriosityTemperature?> temperature = const Value.absent(),
                Value<int?> reflectionIntervalTrials = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PactsCompanion.insert(
                id: id,
                action: action,
                cadence: cadence,
                durationTrials: durationTrials,
                startDate: startDate,
                endDate: endDate,
                status: status,
                createdAt: createdAt,
                ifCondition: ifCondition,
                thenAction: thenAction,
                hypothesis: hypothesis,
                temperature: temperature,
                reflectionIntervalTrials: reflectionIntervalTrials,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PactsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({trialsRefs = false, reflectionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (trialsRefs) db.trials,
                    if (reflectionsRefs) db.reflections,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (trialsRefs)
                        await $_getPrefetchedData<Pact, $PactsTable, Trial>(
                          currentTable: table,
                          referencedTable: $$PactsTableReferences
                              ._trialsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PactsTableReferences(db, table, p0).trialsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pactId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (reflectionsRefs)
                        await $_getPrefetchedData<
                          Pact,
                          $PactsTable,
                          Reflection
                        >(
                          currentTable: table,
                          referencedTable: $$PactsTableReferences
                              ._reflectionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PactsTableReferences(
                                db,
                                table,
                                p0,
                              ).reflectionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pactId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PactsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PactsTable,
      Pact,
      $$PactsTableFilterComposer,
      $$PactsTableOrderingComposer,
      $$PactsTableAnnotationComposer,
      $$PactsTableCreateCompanionBuilder,
      $$PactsTableUpdateCompanionBuilder,
      (Pact, $$PactsTableReferences),
      Pact,
      PrefetchHooks Function({bool trialsRefs, bool reflectionsRefs})
    >;
typedef $$TrialsTableCreateCompanionBuilder =
    TrialsCompanion Function({
      required String id,
      required String pactId,
      required int sessionNumber,
      required int sequenceIndex,
      required DateTime scheduledDate,
      required TrialStatus status,
      required DateTime createdAt,
      Value<DateTime?> completedAt,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$TrialsTableUpdateCompanionBuilder =
    TrialsCompanion Function({
      Value<String> id,
      Value<String> pactId,
      Value<int> sessionNumber,
      Value<int> sequenceIndex,
      Value<DateTime> scheduledDate,
      Value<TrialStatus> status,
      Value<DateTime> createdAt,
      Value<DateTime?> completedAt,
      Value<String?> note,
      Value<int> rowid,
    });

final class $$TrialsTableReferences
    extends BaseReferences<_$AppDatabase, $TrialsTable, Trial> {
  $$TrialsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PactsTable _pactIdTable(_$AppDatabase db) =>
      db.pacts.createAlias($_aliasNameGenerator(db.trials.pactId, db.pacts.id));

  $$PactsTableProcessedTableManager get pactId {
    final $_column = $_itemColumn<String>('pact_id')!;

    final manager = $$PactsTableTableManager(
      $_db,
      $_db.pacts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pactIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TrialsTableFilterComposer
    extends Composer<_$AppDatabase, $TrialsTable> {
  $$TrialsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sessionNumber => $composableBuilder(
    column: $table.sessionNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sequenceIndex => $composableBuilder(
    column: $table.sequenceIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TrialStatus, TrialStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$PactsTableFilterComposer get pactId {
    final $$PactsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pactId,
      referencedTable: $db.pacts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PactsTableFilterComposer(
            $db: $db,
            $table: $db.pacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrialsTableOrderingComposer
    extends Composer<_$AppDatabase, $TrialsTable> {
  $$TrialsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sessionNumber => $composableBuilder(
    column: $table.sessionNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sequenceIndex => $composableBuilder(
    column: $table.sequenceIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$PactsTableOrderingComposer get pactId {
    final $$PactsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pactId,
      referencedTable: $db.pacts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PactsTableOrderingComposer(
            $db: $db,
            $table: $db.pacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrialsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrialsTable> {
  $$TrialsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sessionNumber => $composableBuilder(
    column: $table.sessionNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sequenceIndex => $composableBuilder(
    column: $table.sequenceIndex,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<TrialStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$PactsTableAnnotationComposer get pactId {
    final $$PactsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pactId,
      referencedTable: $db.pacts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PactsTableAnnotationComposer(
            $db: $db,
            $table: $db.pacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrialsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrialsTable,
          Trial,
          $$TrialsTableFilterComposer,
          $$TrialsTableOrderingComposer,
          $$TrialsTableAnnotationComposer,
          $$TrialsTableCreateCompanionBuilder,
          $$TrialsTableUpdateCompanionBuilder,
          (Trial, $$TrialsTableReferences),
          Trial,
          PrefetchHooks Function({bool pactId})
        > {
  $$TrialsTableTableManager(_$AppDatabase db, $TrialsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrialsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrialsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrialsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> pactId = const Value.absent(),
                Value<int> sessionNumber = const Value.absent(),
                Value<int> sequenceIndex = const Value.absent(),
                Value<DateTime> scheduledDate = const Value.absent(),
                Value<TrialStatus> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrialsCompanion(
                id: id,
                pactId: pactId,
                sessionNumber: sessionNumber,
                sequenceIndex: sequenceIndex,
                scheduledDate: scheduledDate,
                status: status,
                createdAt: createdAt,
                completedAt: completedAt,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String pactId,
                required int sessionNumber,
                required int sequenceIndex,
                required DateTime scheduledDate,
                required TrialStatus status,
                required DateTime createdAt,
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrialsCompanion.insert(
                id: id,
                pactId: pactId,
                sessionNumber: sessionNumber,
                sequenceIndex: sequenceIndex,
                scheduledDate: scheduledDate,
                status: status,
                createdAt: createdAt,
                completedAt: completedAt,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TrialsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({pactId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pactId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.pactId,
                                referencedTable: $$TrialsTableReferences
                                    ._pactIdTable(db),
                                referencedColumn: $$TrialsTableReferences
                                    ._pactIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TrialsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrialsTable,
      Trial,
      $$TrialsTableFilterComposer,
      $$TrialsTableOrderingComposer,
      $$TrialsTableAnnotationComposer,
      $$TrialsTableCreateCompanionBuilder,
      $$TrialsTableUpdateCompanionBuilder,
      (Trial, $$TrialsTableReferences),
      Trial,
      PrefetchHooks Function({bool pactId})
    >;
typedef $$ReflectionsTableCreateCompanionBuilder =
    ReflectionsCompanion Function({
      required String id,
      required String pactId,
      required int sessionNumber,
      required ReflectionKind kind,
      required DateTime loggedAt,
      required DateTime createdAt,
      Value<CuriosityTemperature?> temperature,
      Value<String?> note,
      Value<String?> intention,
      Value<ReflectionDecision?> decision,
      Value<String?> decisionNote,
      Value<String?> linkedTrialId,
      Value<int> rowid,
    });
typedef $$ReflectionsTableUpdateCompanionBuilder =
    ReflectionsCompanion Function({
      Value<String> id,
      Value<String> pactId,
      Value<int> sessionNumber,
      Value<ReflectionKind> kind,
      Value<DateTime> loggedAt,
      Value<DateTime> createdAt,
      Value<CuriosityTemperature?> temperature,
      Value<String?> note,
      Value<String?> intention,
      Value<ReflectionDecision?> decision,
      Value<String?> decisionNote,
      Value<String?> linkedTrialId,
      Value<int> rowid,
    });

final class $$ReflectionsTableReferences
    extends BaseReferences<_$AppDatabase, $ReflectionsTable, Reflection> {
  $$ReflectionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PactsTable _pactIdTable(_$AppDatabase db) => db.pacts.createAlias(
    $_aliasNameGenerator(db.reflections.pactId, db.pacts.id),
  );

  $$PactsTableProcessedTableManager get pactId {
    final $_column = $_itemColumn<String>('pact_id')!;

    final manager = $$PactsTableTableManager(
      $_db,
      $_db.pacts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pactIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReflectionsTableFilterComposer
    extends Composer<_$AppDatabase, $ReflectionsTable> {
  $$ReflectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sessionNumber => $composableBuilder(
    column: $table.sessionNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ReflectionKind, ReflectionKind, String>
  get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    CuriosityTemperature?,
    CuriosityTemperature,
    String
  >
  get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get intention => $composableBuilder(
    column: $table.intention,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    ReflectionDecision?,
    ReflectionDecision,
    String
  >
  get decision => $composableBuilder(
    column: $table.decision,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get decisionNote => $composableBuilder(
    column: $table.decisionNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get linkedTrialId => $composableBuilder(
    column: $table.linkedTrialId,
    builder: (column) => ColumnFilters(column),
  );

  $$PactsTableFilterComposer get pactId {
    final $$PactsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pactId,
      referencedTable: $db.pacts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PactsTableFilterComposer(
            $db: $db,
            $table: $db.pacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReflectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReflectionsTable> {
  $$ReflectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sessionNumber => $composableBuilder(
    column: $table.sessionNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get intention => $composableBuilder(
    column: $table.intention,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get decision => $composableBuilder(
    column: $table.decision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get decisionNote => $composableBuilder(
    column: $table.decisionNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get linkedTrialId => $composableBuilder(
    column: $table.linkedTrialId,
    builder: (column) => ColumnOrderings(column),
  );

  $$PactsTableOrderingComposer get pactId {
    final $$PactsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pactId,
      referencedTable: $db.pacts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PactsTableOrderingComposer(
            $db: $db,
            $table: $db.pacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReflectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReflectionsTable> {
  $$ReflectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sessionNumber => $composableBuilder(
    column: $table.sessionNumber,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ReflectionKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CuriosityTemperature?, String>
  get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get intention =>
      $composableBuilder(column: $table.intention, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ReflectionDecision?, String> get decision =>
      $composableBuilder(column: $table.decision, builder: (column) => column);

  GeneratedColumn<String> get decisionNote => $composableBuilder(
    column: $table.decisionNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get linkedTrialId => $composableBuilder(
    column: $table.linkedTrialId,
    builder: (column) => column,
  );

  $$PactsTableAnnotationComposer get pactId {
    final $$PactsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pactId,
      referencedTable: $db.pacts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PactsTableAnnotationComposer(
            $db: $db,
            $table: $db.pacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReflectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReflectionsTable,
          Reflection,
          $$ReflectionsTableFilterComposer,
          $$ReflectionsTableOrderingComposer,
          $$ReflectionsTableAnnotationComposer,
          $$ReflectionsTableCreateCompanionBuilder,
          $$ReflectionsTableUpdateCompanionBuilder,
          (Reflection, $$ReflectionsTableReferences),
          Reflection,
          PrefetchHooks Function({bool pactId})
        > {
  $$ReflectionsTableTableManager(_$AppDatabase db, $ReflectionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReflectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReflectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReflectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> pactId = const Value.absent(),
                Value<int> sessionNumber = const Value.absent(),
                Value<ReflectionKind> kind = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<CuriosityTemperature?> temperature = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> intention = const Value.absent(),
                Value<ReflectionDecision?> decision = const Value.absent(),
                Value<String?> decisionNote = const Value.absent(),
                Value<String?> linkedTrialId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReflectionsCompanion(
                id: id,
                pactId: pactId,
                sessionNumber: sessionNumber,
                kind: kind,
                loggedAt: loggedAt,
                createdAt: createdAt,
                temperature: temperature,
                note: note,
                intention: intention,
                decision: decision,
                decisionNote: decisionNote,
                linkedTrialId: linkedTrialId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String pactId,
                required int sessionNumber,
                required ReflectionKind kind,
                required DateTime loggedAt,
                required DateTime createdAt,
                Value<CuriosityTemperature?> temperature = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> intention = const Value.absent(),
                Value<ReflectionDecision?> decision = const Value.absent(),
                Value<String?> decisionNote = const Value.absent(),
                Value<String?> linkedTrialId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReflectionsCompanion.insert(
                id: id,
                pactId: pactId,
                sessionNumber: sessionNumber,
                kind: kind,
                loggedAt: loggedAt,
                createdAt: createdAt,
                temperature: temperature,
                note: note,
                intention: intention,
                decision: decision,
                decisionNote: decisionNote,
                linkedTrialId: linkedTrialId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReflectionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pactId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pactId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.pactId,
                                referencedTable: $$ReflectionsTableReferences
                                    ._pactIdTable(db),
                                referencedColumn: $$ReflectionsTableReferences
                                    ._pactIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReflectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReflectionsTable,
      Reflection,
      $$ReflectionsTableFilterComposer,
      $$ReflectionsTableOrderingComposer,
      $$ReflectionsTableAnnotationComposer,
      $$ReflectionsTableCreateCompanionBuilder,
      $$ReflectionsTableUpdateCompanionBuilder,
      (Reflection, $$ReflectionsTableReferences),
      Reflection,
      PrefetchHooks Function({bool pactId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PactsTableTableManager get pacts =>
      $$PactsTableTableManager(_db, _db.pacts);
  $$TrialsTableTableManager get trials =>
      $$TrialsTableTableManager(_db, _db.trials);
  $$ReflectionsTableTableManager get reflections =>
      $$ReflectionsTableTableManager(_db, _db.reflections);
}
