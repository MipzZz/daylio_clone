import 'package:flutter/material.dart';

class MoodModel{
  final int id;
  final Icon icon;
  final Color color;
  final int grade;
  final String desc;

  MoodModel({required this.id, required this.grade,required this.icon, required this.color, required this.desc});
}