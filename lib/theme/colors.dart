import 'package:flutter/material.dart';

abstract class BalunColors {
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const greenish = Color(0xFFBFCABD);
  static const red = Color(0xFFFF5B5B);
  static const green = Color(0xFF417B5A);
}

class BalunColorsExtension extends ThemeExtension<BalunColorsExtension> {
  final Color white;
  final Color black;
  final Color greenish;
  final Color red;
  final Color green;

  BalunColorsExtension({
    required this.white,
    required this.black,
    required this.greenish,
    required this.red,
    required this.green,
  });

  @override
  ThemeExtension<BalunColorsExtension> copyWith({
    Color? white,
    Color? black,
    Color? greenish,
    Color? red,
    Color? green,
  }) =>
      BalunColorsExtension(
        white: white ?? this.white,
        black: black ?? this.black,
        greenish: greenish ?? this.greenish,
        red: red ?? this.red,
        green: green ?? this.green,
      );

  @override
  ThemeExtension<BalunColorsExtension> lerp(
    covariant ThemeExtension<BalunColorsExtension>? other,
    double t,
  ) {
    if (other is! BalunColorsExtension) {
      return this;
    }

    return BalunColorsExtension(
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
      greenish: Color.lerp(greenish, other.greenish, t)!,
      red: Color.lerp(red, other.red, t)!,
      green: Color.lerp(green, other.green, t)!,
    );
  }
}
