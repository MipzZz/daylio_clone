import 'dart:ui';

import 'package:flutter/material.dart';

Widget buildBlur({
  required Widget child,
  required bool isLoading,
}) =>
    ImageFiltered(
      imageFilter: ImageFilter.blur(
        sigmaX: isLoading ? 3 : 0,
        sigmaY: isLoading ? 3 : 0,
      ),
      child: child,
    );