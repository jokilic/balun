import 'package:flutter/material.dart';

Color? textToColor(String? colorString) {
  if (colorString != null) {
    final intColor = int.tryParse('0xFF$colorString');

    if (intColor != null) {
      return Color(intColor);
    }
  }

  return null;
}
