import 'package:daylio_clone/src/features/notes/domain/field_converter/color_converter.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sleep_model.g.dart';

@JsonSerializable()
class SleepModel {
  final int? id;
  final String? title;
  final String icon;
  final String? description;
  @ColorConverter()
  final Color color;

  SleepModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.description,
    required this.color,
  });

  SleepModel.empty()
      : this(
          id: 0,
          title: null,
          icon: '',
          description: null,
          color: Colors.white,
        );

  factory SleepModel.fromJson(Map<String, dynamic> json) =>
      _$SleepModelFromJson(json);

  Map<String, dynamic> toJson() => _$SleepModelToJson(this);

  SleepModel copyWith({
    int? id,
    String? title,
    String? icon,
    String? description,
    Color? color,
  }) {
    return SleepModel(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      color: color ?? this.color,
    );
  }
}
