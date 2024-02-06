import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/core/presentation/assets/res/app_icons.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/mood_model.dart';

class MoodsStorage{
  final List<MoodModel> moods = [
    MoodModel(
        id: 0,
        title: 'Отлично',
        selectedIcon: AppIcons.excellentSolid,
        unSelectedIcon: AppIcons.excellentRegular,
        color: AppColors.excellentGrade),
    MoodModel(
        id: 1,
        title: 'Хорошо',
        selectedIcon: AppIcons.goodSolid,
        unSelectedIcon: AppIcons.goodRegular,
        color: AppColors.goodGrade),
    MoodModel(
        id: 2,
        title: 'Нормально',
        selectedIcon: AppIcons.normalSolid,
        unSelectedIcon: AppIcons.normalRegular,
        color: AppColors.normalGrade),
    MoodModel(
        id: 3,
        title: 'Плохо',
        selectedIcon: AppIcons.badSolid,
        unSelectedIcon: AppIcons.badRegular,
        color: AppColors.badGrade),
    MoodModel(
        id: 4,
        title: 'Ужасно',
        selectedIcon: AppIcons.terribleSolid,
        unSelectedIcon: AppIcons.terribleRegular,
        color: AppColors.terribleGrade),
  ];
}