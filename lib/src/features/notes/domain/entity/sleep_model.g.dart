// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SleepModel _$SleepModelFromJson(Map<String, dynamic> json) => SleepModel(
      id: json['id'] as int,
      title: json['title'] as String,
      icon: json['icon'] as String,
      description: json['description'] as String,
      color: const ColorConverter().fromJson(json['color'] as int),
    );

Map<String, dynamic> _$SleepModelToJson(SleepModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'icon': instance.icon,
      'description': instance.description,
      'color': const ColorConverter().toJson(instance.color),
    };
