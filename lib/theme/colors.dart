import 'package:flutter/material.dart';

abstract class BalunColors {
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const grey = Color(0xFF37393B);
  static const greenish = Color(0xFFBFCABD);
  static const red = Color(0xFFED3B3B);
  static const green = Color(0xFF417B5A);
  static const blue = Color(0xFF016FB9);
  static const yellow = Color(0xFFFCC938);
  static const orange = Color(0xFFFF9505);
}

class BalunColorsExtension extends ThemeExtension<BalunColorsExtension> {
  final Color white;
  final Color black;
  final Color grey;
  final Color greenish;
  final Color red;
  final Color green;
  final Color blue;
  final Color yellow;
  final Color orange;

  BalunColorsExtension({
    required this.white,
    required this.black,
    required this.grey,
    required this.greenish,
    required this.red,
    required this.green,
    required this.blue,
    required this.yellow,
    required this.orange,
  });

  @override
  ThemeExtension<BalunColorsExtension> copyWith({
    Color? white,
    Color? black,
    Color? grey,
    Color? greenish,
    Color? red,
    Color? green,
    Color? blue,
    Color? yellow,
    Color? orange,
  }) =>
      BalunColorsExtension(
        white: white ?? this.white,
        black: black ?? this.black,
        grey: grey ?? this.grey,
        greenish: greenish ?? this.greenish,
        red: red ?? this.red,
        green: green ?? this.green,
        blue: blue ?? this.blue,
        yellow: yellow ?? this.yellow,
        orange: orange ?? this.orange,
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
      grey: Color.lerp(grey, other.grey, t)!,
      greenish: Color.lerp(greenish, other.greenish, t)!,
      red: Color.lerp(red, other.red, t)!,
      green: Color.lerp(green, other.green, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      yellow: Color.lerp(yellow, other.yellow, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
    );
  }
}
