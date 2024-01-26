import 'package:flutter/material.dart';

class SleepModel{
  final int id;
  final Icon icon;
  final Color color;
  final int grade;
  final String desc;

  SleepModel({required this.id, required this.grade,required this.icon, required this.color, required this.desc});
}