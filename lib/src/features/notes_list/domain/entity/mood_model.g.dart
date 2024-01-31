// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoodModel _$MoodModelFromJson(Map<String, dynamic> json) => MoodModel(
      title: json['title'] as String,
      icon: Map<String, String>.from(json['icon'] as Map),
      color: const ColorConverter().fromJson(json['color'] as int),
      id: json['id'] as int,
    );

Map<String, dynamic> _$MoodModelToJson(MoodModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'icon': instance.icon,
      'color': const ColorConverter().toJson(instance.color),
    };
