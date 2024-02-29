import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/features/main/domain/entity/bottom_bar_item_entity.dart';
import 'package:flutter/material.dart';

class BottomBarItemWidget extends StatelessWidget {
  const BottomBarItemWidget({
    super.key,
    required this.index,
    required this.onSelectTab,
    required this.isSelected,
  });

  final int index;
  final VoidCallback onSelectTab;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? AppColors.bottomNavigationBarSelectedItemColor
        : AppColors.bottomNavigationBarUnselectedItemColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onSelectTab,
          icon: Icon(BottomBarItemEntity.values[index].icon),
          color: color,
        ),
        FittedBox(
          child: Text(
            BottomBarItemEntity.values[index].title,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
