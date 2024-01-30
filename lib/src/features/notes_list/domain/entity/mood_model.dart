
import 'package:daylio_clone/src/core/presentation/assets/res/app_icons.dart';

enum MoodModel{
  excellent('Отлично', AppIcons.excellentRegular),
  good('Хорошо', AppIcons.goodRegular),
  normal('Нормально',AppIcons.normalRegular),
  bad('Плохо', AppIcons.badRegular),
  terrible('Ужасно', AppIcons.terribleRegular);

  const MoodModel(this.title, this.icon);
  final String title;
  final String icon;
}