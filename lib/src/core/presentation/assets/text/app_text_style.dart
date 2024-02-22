import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyle {
  static const TextStyle statisticText = TextStyle(fontSize: 20);
  static const TextStyle noteListItemSub = TextStyle(
    fontSize: 13,
    color: AppColors.mainTextColor,
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
    color: AppColors.labelTextColor,
  );
  static const TextStyle dateHeader = TextStyle(
    fontSize: 14.5,
    color: AppColors.headerNoteTextColor,
  );
  static const TextStyle missedDaysText = TextStyle(
    color: Color.fromARGB(255, 232, 232, 232),
  );
  static const TextStyle pieChart = TextStyle(
    fontSize: 18,
    color: Colors.black54,
  );
}
