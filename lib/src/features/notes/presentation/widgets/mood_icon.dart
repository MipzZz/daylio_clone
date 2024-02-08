import 'package:daylio_clone/src/core/presentation/assets/res/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MoodIcon extends StatelessWidget {
  final String? iconPath;
  final String? unselectedPath;
  final bool selected;

  final VoidCallback onTap;

  const MoodIcon({
    super.key,
    required this.iconPath,
    required this.unselectedPath,
    required this.onTap,
    required this.selected,
  });

  String get _iconPath =>
      (selected ? iconPath : unselectedPath) ?? AppIcons.badRegular;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        _iconPath,
        width: 50,
        height: 50,
      ),
    );
  }
}