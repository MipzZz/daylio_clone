import 'package:daylio_clone/src/features/notes_list/domain/entity/food_model.dart';
import 'package:drift/drift.dart';
import 'dart:convert';


class FoodModelConverter extends TypeConverter<FoodModel, String>{
  const FoodModelConverter();

  @override
  FoodModel fromSql(String fromDb) {
    return FoodModel.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(FoodModel value) {
    return json.encode(value.toJson());
  }
}