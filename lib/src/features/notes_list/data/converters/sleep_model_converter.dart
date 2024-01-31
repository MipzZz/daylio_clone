import 'package:daylio_clone/src/features/notes_list/domain/entity/sleep_model.dart';
import 'package:drift/drift.dart';
import 'dart:convert';


class SleepModelConverter extends TypeConverter<SleepModel, String>{
  const SleepModelConverter();

  @override
  SleepModel fromSql(String fromDb) {
    return SleepModel.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(SleepModel value) {
    return json.encode(value.toJson());
  }
}