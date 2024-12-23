import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

abstract class AppThemeData {
  static final darkMainTheme = ThemeData(
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: AppColors.background,
      rangePickerHeaderForegroundColor: AppColors.mainTextColor,
      weekdayStyle: TextStyle(color: AppColors.mainTextColor),
      headerForegroundColor: AppColors.mainTextColor,
      dayForegroundColor: MaterialStatePropertyAll(AppColors.mainTextColor),
      yearForegroundColor: MaterialStatePropertyAll(AppColors.mainTextColor),
      todayForegroundColor: MaterialStatePropertyAll(AppColors.mainTextColor),
    ),
    timePickerTheme: const TimePickerThemeData(
      backgroundColor: AppColors.background,
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: AppColors.mainTextColor,
      backgroundColor: AppColors.background,
      titleTextStyle:
      TextStyle(color: AppColors.mainTextColor, fontSize: 20),
    ),
    scaffoldBackgroundColor: AppColors.background,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: AppColors.bottomNavigationBarBackground,
      // selectedItemColor: Colors.black
    ),
    textTheme: Typography.whiteRedmond,
  );
}