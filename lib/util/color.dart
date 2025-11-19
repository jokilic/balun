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
    context.colors.danger,
    context.colors.accentStrong,
    context.colors.info,
    context.colors.warning,
    context.colors.alert,
  ];

  return colors[Random().nextInt(colors.length)];
}

Color lightenColor({
  required Color color,
  required double factor,
}) {
  final hsl = HSLColor.fromColor(color);

  final lightened = hsl.withLightness(
    (hsl.lightness + factor).clamp(0.0, 1.0),
  );

  return lightened.toColor();
}
