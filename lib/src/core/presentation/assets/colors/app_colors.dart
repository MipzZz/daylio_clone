import 'package:flutter/material.dart';

abstract class AppColors{
  static const mainGreen = Color.fromRGBO(49, 163, 129, 0.8);
  static const background = Colors.black;
  static const listBackground = Color.fromRGBO(
      29, 33, 36, 1.0,);
  static const bottomNavigationBarBackground = Color.fromRGBO(6, 192, 116, 1.0);
  static const mainTextColor = Colors.white;
  static const bottomNavigationBarSelectedItemColor = Colors.black;
  static const bottomNavigationBarUnselectedItemColor = Color.fromRGBO(29, 33, 36, 0.67);
  static const labelTextColor = Colors.white70;
  static const headerNoteColor = Color.fromRGBO(27, 62, 56, 1.0);
  static const headerNoteTextColor = Color.fromRGBO(23, 199, 150, 1.0);

  static const excellentGrade = Color(0xFF55BD9B);
  static const goodGrade = Color(0xFF76d589);
  static const normalGrade = Color(0xFf74C0FC);
  static const badGrade = Color(0xFFff943d);
  static const terribleGrade = Color(0xFFfc7373);
}
