import 'dart:convert';

import 'package:daylio_clone/src/features/notes/domain/entity/sleep_model.dart';
import 'package:drift/drift.dart';


class SleepModelConverter extends TypeConverter<SleepModel, String>{
  const SleepModelConverter();

  @override
  SleepModel fromSql(String fromDb) => SleepModel.fromJson(json.decode(fromDb) as Map<String, dynamic>);

  @override
  String toSql(SleepModel value) => json.encode(value.toJson());
}
