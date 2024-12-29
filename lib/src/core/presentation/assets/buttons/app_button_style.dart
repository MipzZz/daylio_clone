import 'package:daylio_clone/src/core/presentation/assets/colors/color_palette.dart';
import 'package:flutter/material.dart';

abstract class AppButtonStyle {
  static const buttonDateTimeStyle = ButtonStyle(
    // TODO(MipZ): Попробовать избавиться от MaterialState
    backgroundColor: WidgetStatePropertyAll<Color>(ColorPalette.background),
    foregroundColor: WidgetStatePropertyAll<Color>(ColorPalette.mainTextColor),
    padding: WidgetStatePropertyAll<EdgeInsets>(
      EdgeInsets.symmetric(vertical: 11.0, horizontal: 15.0),
    ),
  );

  static const addNoteButtonStyle = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll<Color>(ColorPalette.mainGreen),
    foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
    side: WidgetStatePropertyAll<BorderSide>(
      BorderSide(
        color: ColorPalette.mainGreen,
        width: 2,
      ),
    ),
  );

  static const deleteNoteButtonStyle = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll<Color>(Colors.redAccent),
    foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
    side: WidgetStatePropertyAll<BorderSide>(
      BorderSide(color: Colors.redAccent, width: 2),
    ),
  );
}
