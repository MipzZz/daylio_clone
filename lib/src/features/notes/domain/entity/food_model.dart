
import 'package:daylio_clone/src/features/notes/domain/entity/grade_label.dart';
import 'package:daylio_clone/src/features/notes/domain/field_converter/color_converter.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food_model.g.dart';

@JsonSerializable()
class FoodModel {

  FoodModel(
      {required this.id,
      required this.title,
      required this.icon,
      required this.description,
      required this.color,});
  
  factory FoodModel.fromGradeAndDesc({
    required int id,
    required String description,
  }) => FoodModel(
        id: id,
        title: GradeLabel.values[id].title,
        icon: '',
        description: description,
        color: GradeLabel.values[id].color,);

  factory FoodModel.fromJson(Map<String, dynamic> json) =>
      _$FoodModelFromJson(json);
  final int id;
  final String title;
  final String icon;
  final String description;
  @ColorConverter()
  final Color color;

  Map<String, dynamic> toJson() => _$FoodModelToJson(this);

  FoodModel copyWith({
    int? id,
    String? title,
    String? icon,
    String? description,
    Color? color,
  }) => FoodModel(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      color: color ?? this.color,
    );
}
