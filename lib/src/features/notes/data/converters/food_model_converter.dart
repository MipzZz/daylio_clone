import 'dart:convert';

import 'package:daylio_clone/src/features/notes/domain/entity/food_model.dart';
import 'package:drift/drift.dart';

class FoodModelConverter extends TypeConverter<FoodModel, String> {
  const FoodModelConverter();

  @override
  FoodModel fromSql(String fromDb) => FoodModel.fromJson(json.decode(fromDb) as Map<String, dynamic>);

  @override
  String toSql(FoodModel value) => json.encode(value.toJson());
}
