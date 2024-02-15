import 'dart:convert';

import 'package:daylio_clone/src/features/notes/domain/entity/mood_model.dart';
import 'package:drift/drift.dart';


class MoodModelConverter extends TypeConverter<MoodModel, String>{
  const MoodModelConverter();

  @override
  MoodModel fromSql(String fromDb) => MoodModel.fromJson(json.decode(fromDb) as Map<String, dynamic>);

  @override
  String toSql(MoodModel value) => json.encode(value.toJson());
}
