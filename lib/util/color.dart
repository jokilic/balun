import 'dart:math';

import 'package:flutter/material.dart';

import '../theme/theme.dart';

Color? textToColor(String? colorString) {
  if (colorString != null) {
    final intColor = int.tryParse('0xFF$colorString');

    if (intColor != null) {
      return Color(intColor);
    }
  }

  return null;
}

Color getRandomBalunColor(BuildContext context) {
  final colors = [
    context.colors.red,
    context.colors.green,
    context.colors.blue,
    context.colors.yellow,
    context.colors.orange,
  ];

  return colors[Random().nextInt(colors.length)];
}
