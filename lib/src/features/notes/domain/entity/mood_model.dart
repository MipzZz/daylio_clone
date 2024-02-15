import 'package:daylio_clone/src/features/notes/domain/entity/moods_storage.dart';
import 'package:daylio_clone/src/features/notes/domain/field_converter/color_converter.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mood_model.g.dart';

@JsonSerializable()
class MoodModel {

  MoodModel({
    required this.id,
    required this.title,
    required this.selectedIcon,
    required this.unSelectedIcon,
    required this.color,
  });

  factory MoodModel.fromJson(Map<String, dynamic> json) =>
      _$MoodModelFromJson(json);

  MoodModel.empty()
      : this(
            id: 0,
            title: '',
            selectedIcon: '',
            unSelectedIcon: '',
            color: Colors.white,);

  factory MoodModel.fromEnum(MoodsStorage moodEnum) => MoodModel(
      id: moodEnum.id,
      title: moodEnum.title,
      selectedIcon: moodEnum.selectedIcon,
      unSelectedIcon: moodEnum.unSelectedIcon,
      color: moodEnum.color,
    );
  final int id;
  final String title;
  final String selectedIcon;
  final String unSelectedIcon;
  @ColorConverter()
  final Color color;

  Map<String, dynamic> toJson() => _$MoodModelToJson(this);

  MoodModel copyWith({
    int? id,
    String? title,
    String? selectedIcon,
    String? unSelectedIcon,
    Color? color,
  }) => MoodModel(
      id: id ?? this.id,
      title: title ?? this.title,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      unSelectedIcon: unSelectedIcon ?? this.unSelectedIcon,
      color: color ?? this.color,
    );
}
