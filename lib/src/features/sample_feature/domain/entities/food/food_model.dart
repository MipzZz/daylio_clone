import 'package:flutter/material.dart';

class FoodModel{
  final int id;
  final Icon icon;
  final Color color;
  final int grade;
  final String desc;

  FoodModel({required this.id, required this.grade,required this.icon, required this.color, required this.desc});
}