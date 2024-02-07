// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_storage.dart';

// ignore_for_file: type=lint
class $NoteTableTable extends NoteTable
    with TableInfo<$NoteTableTable, NoteTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NoteTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumnWithTypeConverter<MoodModel, String> mood =
      GeneratedColumn<String>('mood', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<MoodModel>($NoteTableTable.$convertermood);
  static const VerificationMeta _foodMeta = const VerificationMeta('food');
  @override
  late final GeneratedColumnWithTypeConverter<FoodModel?, String> food =
      GeneratedColumn<String>('food', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<FoodModel?>($NoteTableTable.$converterfoodn);
  static const VerificationMeta _sleepMeta = const VerificationMeta('sleep');
  @override
  late final GeneratedColumnWithTypeConverter<SleepModel?, String> sleep =
      GeneratedColumn<String>('sleep', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<SleepModel?>($NoteTableTable.$convertersleepn);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, mood, food, sleep, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'note_table';
  @override
  VerificationContext validateIntegrity(Insertable<NoteTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_moodMeta, const VerificationResult.success());
    context.handle(_foodMeta, const VerificationResult.success());
    context.handle(_sleepMeta, const VerificationResult.success());
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NoteTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      mood: $NoteTableTable.$convertermood.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mood'])!),
      food: $NoteTableTable.$converterfoodn.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}food'])),
      sleep: $NoteTableTable.$convertersleepn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sleep'])),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $NoteTableTable createAlias(String alias) {
    return $NoteTableTable(attachedDatabase, alias);
  }

  static TypeConverter<MoodModel, String> $convertermood =
      const MoodModelConverter();
  static TypeConverter<FoodModel, String> $converterfood =
      const FoodModelConverter();
  static TypeConverter<FoodModel?, String?> $converterfoodn =
      NullAwareTypeConverter.wrap($converterfood);
  static TypeConverter<SleepModel, String> $convertersleep =
      const SleepModelConverter();
  static TypeConverter<SleepModel?, String?> $convertersleepn =
      NullAwareTypeConverter.wrap($convertersleep);
}

class NoteTableData extends DataClass implements Insertable<NoteTableData> {
  final int id;
  final MoodModel mood;
  final FoodModel? food;
  final SleepModel? sleep;
  final DateTime date;
  const NoteTableData(
      {required this.id,
      required this.mood,
      this.food,
      this.sleep,
      required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['mood'] =
          Variable<String>($NoteTableTable.$convertermood.toSql(mood));
    }
    if (!nullToAbsent || food != null) {
      map['food'] =
          Variable<String>($NoteTableTable.$converterfoodn.toSql(food));
    }
    if (!nullToAbsent || sleep != null) {
      map['sleep'] =
          Variable<String>($NoteTableTable.$convertersleepn.toSql(sleep));
    }
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  NoteTableCompanion toCompanion(bool nullToAbsent) {
    return NoteTableCompanion(
      id: Value(id),
      mood: Value(mood),
      food: food == null && nullToAbsent ? const Value.absent() : Value(food),
      sleep:
          sleep == null && nullToAbsent ? const Value.absent() : Value(sleep),
      date: Value(date),
    );
  }

  factory NoteTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteTableData(
      id: serializer.fromJson<int>(json['id']),
      mood: serializer.fromJson<MoodModel>(json['mood']),
      food: serializer.fromJson<FoodModel?>(json['food']),
      sleep: serializer.fromJson<SleepModel?>(json['sleep']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mood': serializer.toJson<MoodModel>(mood),
      'food': serializer.toJson<FoodModel?>(food),
      'sleep': serializer.toJson<SleepModel?>(sleep),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  NoteTableData copyWith(
          {int? id,
          MoodModel? mood,
          Value<FoodModel?> food = const Value.absent(),
          Value<SleepModel?> sleep = const Value.absent(),
          DateTime? date}) =>
      NoteTableData(
        id: id ?? this.id,
        mood: mood ?? this.mood,
        food: food.present ? food.value : this.food,
        sleep: sleep.present ? sleep.value : this.sleep,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('NoteTableData(')
          ..write('id: $id, ')
          ..write('mood: $mood, ')
          ..write('food: $food, ')
          ..write('sleep: $sleep, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, mood, food, sleep, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteTableData &&
          other.id == this.id &&
          other.mood == this.mood &&
          other.food == this.food &&
          other.sleep == this.sleep &&
          other.date == this.date);
}

class NoteTableCompanion extends UpdateCompanion<NoteTableData> {
  final Value<int> id;
  final Value<MoodModel> mood;
  final Value<FoodModel?> food;
  final Value<SleepModel?> sleep;
  final Value<DateTime> date;
  const NoteTableCompanion({
    this.id = const Value.absent(),
    this.mood = const Value.absent(),
    this.food = const Value.absent(),
    this.sleep = const Value.absent(),
    this.date = const Value.absent(),
  });
  NoteTableCompanion.insert({
    this.id = const Value.absent(),
    required MoodModel mood,
    this.food = const Value.absent(),
    this.sleep = const Value.absent(),
    required DateTime date,
  })  : mood = Value(mood),
        date = Value(date);
  static Insertable<NoteTableData> custom({
    Expression<int>? id,
    Expression<String>? mood,
    Expression<String>? food,
    Expression<String>? sleep,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mood != null) 'mood': mood,
      if (food != null) 'food': food,
      if (sleep != null) 'sleep': sleep,
      if (date != null) 'date': date,
    });
  }

  NoteTableCompanion copyWith(
      {Value<int>? id,
      Value<MoodModel>? mood,
      Value<FoodModel?>? food,
      Value<SleepModel?>? sleep,
      Value<DateTime>? date}) {
    return NoteTableCompanion(
      id: id ?? this.id,
      mood: mood ?? this.mood,
      food: food ?? this.food,
      sleep: sleep ?? this.sleep,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mood.present) {
      map['mood'] =
          Variable<String>($NoteTableTable.$convertermood.toSql(mood.value));
    }
    if (food.present) {
      map['food'] =
          Variable<String>($NoteTableTable.$converterfoodn.toSql(food.value));
    }
    if (sleep.present) {
      map['sleep'] =
          Variable<String>($NoteTableTable.$convertersleepn.toSql(sleep.value));
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NoteTableCompanion(')
          ..write('id: $id, ')
          ..write('mood: $mood, ')
          ..write('food: $food, ')
          ..write('sleep: $sleep, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  late final $NoteTableTable noteTable = $NoteTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [noteTable];
}
