import 'package:daylio_clone/src/core/presentation/assets/colors/color_palette.dart';
import 'package:flutter/material.dart';

// TODO(MipZ): Дописать колор схему
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  const AppColorScheme._({required this.primary});

  AppColorScheme.light() : primary = ColorPalette.primary;

  AppColorScheme.dark() : primary = ColorPalette.primary;

  final Color primary;

  @override
  ThemeExtension<AppColorScheme> copyWith({
    Color? primary,
  }) =>
      AppColorScheme._(
        primary: primary ?? this.primary,
      );

  @override
  ThemeExtension<AppColorScheme> lerp(ThemeExtension<AppColorScheme>? other, double t) {
    if (other is! AppColorScheme) {
      return this;
    }
    return AppColorScheme._(
      primary: Color.lerp(primary, other.primary, t)!,
    );
  }

  /// Returns [AppColorScheme] from [context].
  static AppColorScheme of(BuildContext context) => Theme.of(context).extension<AppColorScheme>()!;
}
