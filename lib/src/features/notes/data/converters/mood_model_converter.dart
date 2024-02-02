import 'package:daylio_clone/src/features/notes/domain/entity/mood_model.dart';
import 'package:drift/drift.dart';
import 'dart:convert';


class MoodModelConverter extends TypeConverter<MoodModel, String>{
  const MoodModelConverter();

  @override
  MoodModel fromSql(String fromDb) {
    return MoodModel.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(MoodModel value) {
    return json.encode(value.toJson());
  }
}