import 'package:daylio_clone/src/features/notes_list/domain/field_converter/color_converter.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mood_model.g.dart';

@JsonSerializable()
class MoodModel {
  final int id;
  final String title;
  final Map<String, String> icon;
  @ColorConverter()
  final Color color;

  MoodModel({required this.title, required this.icon, required this.color, required this.id});

  MoodModel.empty() : this(id: 0, title: '', icon: {}, color: Colors.white);

  factory MoodModel.fromJson(Map<String, dynamic> json) =>
      _$MoodModelFromJson(json);

  Map<String, dynamic> toJson() => _$MoodModelToJson(this);
}


