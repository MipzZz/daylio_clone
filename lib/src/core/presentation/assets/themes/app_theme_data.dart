import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppThemeData {
  static final darkMainTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      // Splash, выделение, цвет рефреш значка, изменение цвета аппабра при скролее
      primary: AppColors.primary,
      // primaryContainer: Colors.orangeAccent,
      // цвет на выделении
      onPrimary: AppColors.onPrimary,
      // Выделение периода
      secondary: AppColors.secondary,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondary: Colors.lime,
      error: Colors.redAccent,
      onError: Colors.redAccent,
      background: AppColors.background,
      onBackground: Colors.grey,
      // Цвет дропдаун меню, пик даты, пик веремени меню
      surface: AppColors.surface,
      // Цвет текста пик даты, пик веремени меню, дропдаун меню
      onSurface: AppColors.onSurface,
    ),
    datePickerTheme: const DatePickerThemeData(
      surfaceTintColor: AppColors.surfaceTintColor,
    ),
    timePickerTheme: const TimePickerThemeData(
      backgroundColor: AppColors.timePickerBackGroundColor,
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: AppColors.mainTextColor,
      backgroundColor: AppColors.background,
      titleTextStyle: TextStyle(
        color: AppColors.mainTextColor,
        fontSize: 20,
      ),
    ),
    scaffoldBackgroundColor: AppColors.background,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: AppColors.bottomNavigationBarBackground,
      // selectedItemColor: Colors.black
    ),
    textTheme: Typography.whiteRedmond,
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.accent,
    ),
  );
}
