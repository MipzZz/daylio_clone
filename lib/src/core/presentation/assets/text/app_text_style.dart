import 'package:daylio_clone/src/core/presentation/assets/colors/color_palette.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyle {
  static const TextStyle statisticText = TextStyle(fontSize: 20);
  static const TextStyle noteListItemSub = TextStyle(
    fontSize: 13,
    color: ColorPalette.mainTextColor,
  );
  static const TextStyle title = TextStyle(
    fontSize: 18,
    color: Colors.white,
  );
  static const TextStyle subTitle = TextStyle(
    fontSize: 14,
    color: Colors.white70,
  );
  static const TextStyle dropdownLabel = TextStyle(
    fontSize: 16.5,
    color: ColorPalette.labelTextColor,
  );
  static const TextStyle dateHeader = TextStyle(
    fontSize: 14.5,
    color: ColorPalette.headerNoteTextColor,
  );
  static const TextStyle missedDaysText = TextStyle(
    color: Color.fromARGB(255, 232, 232, 232),
  );
  static const TextStyle pieChart = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    shadows: [Shadow(color: Colors.black, blurRadius: 2)],
    color: Colors.white,
  );
  static const TextStyle rangeText = TextStyle(
    fontSize: 16,
    color: ColorPalette.mainTextColor,
  );
}
