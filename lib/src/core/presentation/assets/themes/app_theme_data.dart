import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppThemeData {
  static final darkMainTheme = ThemeData(
    datePickerTheme: const DatePickerThemeData(
      surfaceTintColor: Colors.white,
      backgroundColor: AppColors.background,
      rangePickerHeaderForegroundColor: AppColors.mainTextColor,
      weekdayStyle: TextStyle(color: AppColors.mainTextColor),
      headerForegroundColor: AppColors.mainTextColor,

      dayForegroundColor: MaterialStatePropertyAll(AppColors.mainTextColor),
      yearForegroundColor: MaterialStatePropertyAll(AppColors.mainTextColor),
      yearOverlayColor: MaterialStatePropertyAll(AppColors.mainGreen),
      yearStyle: TextStyle(color: Colors.green),
      todayForegroundColor: MaterialStatePropertyAll(AppColors.mainTextColor),
    ),
    timePickerTheme: const TimePickerThemeData(
      backgroundColor: Color.fromARGB(255, 30, 30, 30),
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
