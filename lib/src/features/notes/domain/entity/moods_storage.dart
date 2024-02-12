import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/core/presentation/assets/res/app_icons.dart';
import 'package:flutter/material.dart';

enum MoodsStorage {
  excellent(
    id: 0,
    title: 'Отлично',
    selectedIcon: AppIcons.excellentSolid,
    unSelectedIcon: AppIcons.excellentRegular,
    color: AppColors.excellentGrade,
  ),
  good(
    id: 1,
    title: 'Хорошо',
    selectedIcon: AppIcons.goodSolid,
    unSelectedIcon: AppIcons.goodRegular,
    color: AppColors.goodGrade,
  ),
  normal(
    id: 2,
    title: 'Нормально',
    selectedIcon: AppIcons.normalSolid,
    unSelectedIcon: AppIcons.normalRegular,
    color: AppColors.normalGrade,
  ),
  bad(
    id: 3,
    title: 'Плохо',
    selectedIcon: AppIcons.badSolid,
    unSelectedIcon: AppIcons.badRegular,
    color: AppColors.badGrade,
  ),
  terrible(
    id: 4,
    title: 'Ужасно',
    selectedIcon: AppIcons.terribleSolid,
    unSelectedIcon: AppIcons.terribleRegular,
    color: AppColors.terribleGrade,
  );

  final int id;
  final String title;
  final String selectedIcon;
  final String unSelectedIcon;
  final Color color;

  const MoodsStorage({
    required this.id,
    required this.title,
    required this.selectedIcon,
    required this.unSelectedIcon,
    required this.color,
  });
}
