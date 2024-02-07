import 'dart:ui';

import 'package:daylio_clone/src/features/notes/domain/field_converter/color_converter.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food_model.g.dart';

@JsonSerializable()
class FoodModel {
  final int? id;
  final String? title;
  final String icon;
  final String? description;
  @ColorConverter()
  final Color color;

  FoodModel(
      {required this.id,
      required this.title,
      required this.icon,
      required this.description,
      required this.color});

  FoodModel.empty()
      : this(id: 0, title: null, icon: '', description: null, color: Colors.white);

  factory FoodModel.fromJson(Map<String, dynamic> json) =>
      _$FoodModelFromJson(json);

  Map<String, dynamic> toJson() => _$FoodModelToJson(this);

  FoodModel copyWith({
    int? id,
    String? title,
    String? icon,
    String? description,
    Color? color,
  }) {
    return FoodModel(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      color: color ?? this.color,
    );
  }
}
