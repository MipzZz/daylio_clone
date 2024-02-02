import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/core/presentation/assets/res/app_icons.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/mood_model.dart';

class MoodsStorage{
  final List<MoodModel> moods = [
    MoodModel(
        id: 0,
        title: 'Отлично',
        icon: {
          'selected': AppIcons.excellentSolid,
          'notSelected': AppIcons.excellentRegular
        },
        color: AppColors.excellentGrade),
    MoodModel(
        id: 1,
        title: 'Хорошо',
        icon: {
          'selected': AppIcons.goodSolid,
          'notSelected': AppIcons.goodRegular
        },
        color: AppColors.goodGrade),
    MoodModel(
        id: 2,
        title: 'Нормально',
        icon: {
          'selected': AppIcons.normalSolid,
          'notSelected': AppIcons.normalRegular
        },
        color: AppColors.normalGrade),
    MoodModel(
        id: 3,
        title: 'Плохо',
        icon: {
          'selected': AppIcons.badSolid,
          'notSelected': AppIcons.badRegular
        },
        color: AppColors.badGrade),
    MoodModel(
        id: 4,
        title: 'Ужасно',
        icon: {
          'selected': AppIcons.terribleSolid,
          'notSelected': AppIcons.terribleRegular
        },
        color: AppColors.terribleGrade),
  ];
}