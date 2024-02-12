import 'dart:ui';

import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';

enum GradeLabel{
  excellent('Отлично', AppColors.excellentGrade),
  good('Хорошо', AppColors.goodGrade),
  normal('Нормально', AppColors.normalGrade),
  bad('Плохо', AppColors.badGrade),
  terrible('Ужасно', AppColors.terribleGrade);

  final String title;
  final Color color;

  const GradeLabel(this.title, this.color);

}