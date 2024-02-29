import 'package:flutter/material.dart';

enum BottomBarItemEntity {
  notes(title: 'Записи', icon: Icons.notes),
  statistic(title: 'Статистика', icon: Icons.bar_chart),
  more(title: 'Более', icon: Icons.more_horiz);

  const BottomBarItemEntity({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;
}
