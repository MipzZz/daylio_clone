import 'package:daylio_clone/src/features/notes/domain/field_converter/color_converter.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mood_model.g.dart';

@JsonSerializable()
class MoodModel {
  final int id;
  final String title;
  // final Map<String, String> icon;
  final String selectedIcon;
  final String unSelectedIcon;
  @ColorConverter()
  final Color color;

  MoodModel(
      {required this.title,
      required this.icon,
      required this.color,
      required this.id});

  MoodModel.empty() : this(id: 0, title: '', icon: {}, color: Colors.white);

  factory MoodModel.fromJson(Map<String, dynamic> json) =>
      _$MoodModelFromJson(json);

  Map<String, dynamic> toJson() => _$MoodModelToJson(this);

  MoodModel copyWith({
    int? id,
    String? title,
    Map<String, String>? icon,
    Color? color,
  }) {
    return MoodModel(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }
}
