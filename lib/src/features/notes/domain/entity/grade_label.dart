import 'dart:ui';

import 'package:daylio_clone/src/core/presentation/assets/colors/color_palette.dart';

enum GradeLabel{
  excellent('Отлично', ColorPalette.excellentGrade),
  good('Хорошо', ColorPalette.goodGrade),
  normal('Нормально', ColorPalette.normalGrade),
  bad('Плохо', ColorPalette.badGrade),
  terrible('Ужасно', ColorPalette.terribleGrade);

  const GradeLabel(this.title, this.color);

  final String title;
  final Color color;



}
