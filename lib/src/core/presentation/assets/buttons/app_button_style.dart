import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppButtonStyle {
  static const buttonDateTimeStyle = ButtonStyle(
    // TODO(MipZ): Попробовать избавиться от MaterialState
    backgroundColor: MaterialStatePropertyAll<Color>(AppColors.background),
    foregroundColor: MaterialStatePropertyAll<Color>(AppColors.mainTextColor),
  );

  static const addNoteButtonStyle = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll<Color>(AppColors.mainGreen),
    foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
    side: MaterialStatePropertyAll<BorderSide>(
      BorderSide(
        color: AppColors.mainGreen,
        width: 2,
      ),
    ),
  );

  static const deleteNoteButtonStyle = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll<Color>(Colors.redAccent),
    foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
    side: MaterialStatePropertyAll<BorderSide>(
      BorderSide(color: Colors.redAccent, width: 2),
    ),
  );
}
