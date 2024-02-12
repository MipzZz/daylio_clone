// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoodModel _$MoodModelFromJson(Map<String, dynamic> json) => MoodModel(
      id: json['id'] as int,
      title: json['title'] as String,
      selectedIcon: json['selectedIcon'] as String,
      unSelectedIcon: json['unSelectedIcon'] as String,
      color: const ColorConverter().fromJson(json['color'] as int),
    );

Map<String, dynamic> _$MoodModelToJson(MoodModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'selectedIcon': instance.selectedIcon,
      'unSelectedIcon': instance.unSelectedIcon,
      'color': const ColorConverter().toJson(instance.color),
    };
