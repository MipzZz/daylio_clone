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
  late final GeneratedColumn<String> mood = GeneratedColumn<String>(
      'mood', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _foodMeta = const VerificationMeta('food');
  @override
  late final GeneratedColumn<String> food = GeneratedColumn<String>(
      'food', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sleepMeta = const VerificationMeta('sleep');
  @override
  late final GeneratedColumn<String> sleep = GeneratedColumn<String>(
      'sleep', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, mood, food, sleep];
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
    if (data.containsKey('mood')) {
      context.handle(
          _moodMeta, mood.isAcceptableOrUnknown(data['mood']!, _moodMeta));
    } else if (isInserting) {
      context.missing(_moodMeta);
    }
    if (data.containsKey('food')) {
      context.handle(
          _foodMeta, food.isAcceptableOrUnknown(data['food']!, _foodMeta));
    } else if (isInserting) {
      context.missing(_foodMeta);
    }
    if (data.containsKey('sleep')) {
      context.handle(
          _sleepMeta, sleep.isAcceptableOrUnknown(data['sleep']!, _sleepMeta));
    } else if (isInserting) {
      context.missing(_sleepMeta);
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
      mood: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mood'])!,
      food: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}food'])!,
      sleep: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sleep'])!,
    );
  }

  @override
  $NoteTableTable createAlias(String alias) {
    return $NoteTableTable(attachedDatabase, alias);
  }
}

class NoteTableData extends DataClass implements Insertable<NoteTableData> {
  final int id;
  final String mood;
  final String food;
  final String sleep;
  const NoteTableData(
      {required this.id,
      required this.mood,
      required this.food,
      required this.sleep});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mood'] = Variable<String>(mood);
    map['food'] = Variable<String>(food);
    map['sleep'] = Variable<String>(sleep);
    return map;
  }

  NoteTableCompanion toCompanion(bool nullToAbsent) {
    return NoteTableCompanion(
      id: Value(id),
      mood: Value(mood),
      food: Value(food),
      sleep: Value(sleep),
    );
  }

  factory NoteTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteTableData(
      id: serializer.fromJson<int>(json['id']),
      mood: serializer.fromJson<String>(json['mood']),
      food: serializer.fromJson<String>(json['food']),
      sleep: serializer.fromJson<String>(json['sleep']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mood': serializer.toJson<String>(mood),
      'food': serializer.toJson<String>(food),
      'sleep': serializer.toJson<String>(sleep),
    };
  }

  NoteTableData copyWith(
          {int? id, String? mood, String? food, String? sleep}) =>
      NoteTableData(
        id: id ?? this.id,
        mood: mood ?? this.mood,
        food: food ?? this.food,
        sleep: sleep ?? this.sleep,
      );
  @override
  String toString() {
    return (StringBuffer('NoteTableData(')
          ..write('id: $id, ')
          ..write('mood: $mood, ')
          ..write('food: $food, ')
          ..write('sleep: $sleep')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, mood, food, sleep);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteTableData &&
          other.id == this.id &&
          other.mood == this.mood &&
          other.food == this.food &&
          other.sleep == this.sleep);
}

class NoteTableCompanion extends UpdateCompanion<NoteTableData> {
  final Value<int> id;
  final Value<String> mood;
  final Value<String> food;
  final Value<String> sleep;
  const NoteTableCompanion({
    this.id = const Value.absent(),
    this.mood = const Value.absent(),
    this.food = const Value.absent(),
    this.sleep = const Value.absent(),
  });
  NoteTableCompanion.insert({
    this.id = const Value.absent(),
    required String mood,
    required String food,
    required String sleep,
  })  : mood = Value(mood),
        food = Value(food),
        sleep = Value(sleep);
  static Insertable<NoteTableData> custom({
    Expression<int>? id,
    Expression<String>? mood,
    Expression<String>? food,
    Expression<String>? sleep,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mood != null) 'mood': mood,
      if (food != null) 'food': food,
      if (sleep != null) 'sleep': sleep,
    });
  }

  NoteTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? mood,
      Value<String>? food,
      Value<String>? sleep}) {
    return NoteTableCompanion(
      id: id ?? this.id,
      mood: mood ?? this.mood,
      food: food ?? this.food,
      sleep: sleep ?? this.sleep,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mood.present) {
      map['mood'] = Variable<String>(mood.value);
    }
    if (food.present) {
      map['food'] = Variable<String>(food.value);
    }
    if (sleep.present) {
      map['sleep'] = Variable<String>(sleep.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NoteTableCompanion(')
          ..write('id: $id, ')
          ..write('mood: $mood, ')
          ..write('food: $food, ')
          ..write('sleep: $sleep')
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
