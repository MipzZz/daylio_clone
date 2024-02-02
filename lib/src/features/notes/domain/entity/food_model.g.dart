// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodModel _$FoodModelFromJson(Map<String, dynamic> json) => FoodModel(
      id: json['id'] as int,
      title: json['title'] as String,
      icon: json['icon'] as String,
      description: json['description'] as String,
      color: const ColorConverter().fromJson(json['color'] as int),
    );

Map<String, dynamic> _$FoodModelToJson(FoodModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'icon': instance.icon,
      'description': instance.description,
      'color': const ColorConverter().toJson(instance.color),
    };
