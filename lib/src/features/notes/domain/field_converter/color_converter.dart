import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

class ColorConverter extends JsonConverter<Color, int> {
  const ColorConverter();

  @override
  fromJson(json) {
    return Color(json);
  }

  @override
  toJson(object) {
    return object.value;
  }
}