import 'package:daylio_clone/src/core/presentation/assets/colors/color_palette.dart';
import 'package:daylio_clone/src/core/presentation/assets/colors/color_scheme.dart';
import 'package:flutter/material.dart';

abstract class AppThemeData {

  static final lightTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: _lightColorScheme.primary,
      onPrimary: ColorPalette.onPrimary,
      secondary: ColorPalette.secondary,
      secondaryContainer: ColorPalette.secondaryContainer,
      onSecondary: Colors.lime,
      error: Colors.redAccent,
      onError: Colors.redAccent,
      surface: ColorPalette.surface,
      onSurface: ColorPalette.onSurface,
    ),
    datePickerTheme: const DatePickerThemeData(
      surfaceTintColor: ColorPalette.surfaceTintColor,
    ),
    timePickerTheme: const TimePickerThemeData(
      backgroundColor: ColorPalette.timePickerBackGroundColor,
    ),
    extensions: [_lightColorScheme],
  );


  static final darkTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: _darkColorScheme.primary,
      onPrimary: ColorPalette.onPrimary,
      secondary: ColorPalette.secondary,
      secondaryContainer: ColorPalette.secondaryContainer,
      onSecondary: Colors.lime,
      error: Colors.redAccent,
      onError: Colors.redAccent,
      surface: ColorPalette.surface,
      onSurface: ColorPalette.onSurface,
    ),
    datePickerTheme: const DatePickerThemeData(
      surfaceTintColor: ColorPalette.surfaceTintColor,
    ),
    timePickerTheme: const TimePickerThemeData(
      backgroundColor: ColorPalette.timePickerBackGroundColor,
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: ColorPalette.mainTextColor,
      backgroundColor: ColorPalette.background,
      titleTextStyle: TextStyle(
        color: ColorPalette.mainTextColor,
        fontSize: 20,
      ),
    ),
    scaffoldBackgroundColor: ColorPalette.background,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: ColorPalette.bottomNavigationBarBackground,
    ),
    textTheme: Typography.whiteRedmond,
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.accent,
    ),
  );

  static final _lightColorScheme = AppColorScheme.light();
  static final _darkColorScheme = AppColorScheme.dark();
}
