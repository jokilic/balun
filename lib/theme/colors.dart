import 'package:flutter/material.dart';

abstract class BalunColors {
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF292928);
  static const grey = Color(0xFF303131);

  static const lightGreen = Color(0xFFBFCABD);
  static const darkGreen = Color(0xFF417B5A);

  static const red = Color(0xFFED3B3B);
  static const blue = Color(0xFF016FB9);
  static const yellow = Color(0xFFFCC938);
  static const orange = Color(0xFFFF9505);
}

class BalunColorsExtension extends ThemeExtension<BalunColorsExtension> {
  final Color primaryBackground;
  final Color primaryForeground;
  final Color secondaryBackground;
  final Color accentLight;
  final Color accentStrong;
  final Color danger;
  final Color info;
  final Color warning;
  final Color alert;

  BalunColorsExtension({
    required this.primaryBackground,
    required this.primaryForeground,
    required this.secondaryBackground,
    required this.accentLight,
    required this.accentStrong,
    required this.danger,
    required this.info,
    required this.warning,
    required this.alert,
  });

  @override
  ThemeExtension<BalunColorsExtension> copyWith({
    Color? primaryBackground,
    Color? primaryForeground,
    Color? secondaryBackground,
    Color? accentLight,
    Color? accentStrong,
    Color? danger,
    Color? info,
    Color? warning,
    Color? alert,
  }) => BalunColorsExtension(
    primaryBackground: primaryBackground ?? this.primaryBackground,
    primaryForeground: primaryForeground ?? this.primaryForeground,
    secondaryBackground: secondaryBackground ?? this.secondaryBackground,
    accentLight: accentLight ?? this.accentLight,
    accentStrong: accentStrong ?? this.accentStrong,
    danger: danger ?? this.danger,
    info: info ?? this.info,
    warning: warning ?? this.warning,
    alert: alert ?? this.alert,
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
      primaryBackground: Color.lerp(primaryBackground, other.primaryBackground, t)!,
      primaryForeground: Color.lerp(primaryForeground, other.primaryForeground, t)!,
      secondaryBackground: Color.lerp(secondaryBackground, other.secondaryBackground, t)!,
      accentLight: Color.lerp(accentLight, other.accentLight, t)!,
      accentStrong: Color.lerp(accentStrong, other.accentStrong, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      info: Color.lerp(info, other.info, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      alert: Color.lerp(alert, other.alert, t)!,
    );
  }
}
