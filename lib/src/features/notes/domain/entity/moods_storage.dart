import 'package:daylio_clone/src/core/presentation/assets/colors/color_palette.dart';
import 'package:daylio_clone/src/core/presentation/assets/res/app_icons.dart';
import 'package:flutter/material.dart';

enum MoodsStorage {
  excellent(
    id: 0,
    title: 'Отлично',
    selectedIcon: AppIcons.excellentSolid,
    unSelectedIcon: AppIcons.excellentRegular,
    color: ColorPalette.excellentGrade,
  ),
  good(
    id: 1,
    title: 'Хорошо',
    selectedIcon: AppIcons.goodSolid,
    unSelectedIcon: AppIcons.goodRegular,
    color: ColorPalette.goodGrade,
  ),
  normal(
    id: 2,
    title: 'Нормально',
    selectedIcon: AppIcons.normalSolid,
    unSelectedIcon: AppIcons.normalRegular,
    color: ColorPalette.normalGrade,
  ),
  bad(
    id: 3,
    title: 'Плохо',
    selectedIcon: AppIcons.badSolid,
    unSelectedIcon: AppIcons.badRegular,
    color: ColorPalette.badGrade,
  ),
  terrible(
    id: 4,
    title: 'Ужасно',
    selectedIcon: AppIcons.terribleSolid,
    unSelectedIcon: AppIcons.terribleRegular,
    color: ColorPalette.terribleGrade,
  );

  const MoodsStorage({
    required this.id,
    required this.title,
    required this.selectedIcon,
    required this.unSelectedIcon,
    required this.color,
  });

  final int id;
  final String title;
  final String selectedIcon;
  final String unSelectedIcon;
  final Color color;


}
