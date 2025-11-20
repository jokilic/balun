import 'package:flutter/material.dart';

import '../util/color.dart';

abstract class BalunColors {
  ///
  /// LIGHT
  ///

  static const light = Color(0xFFBFCABD);
  static final middleLight = lightenColor(
    color: light,
    factor: 0.02,
  );
  static final lightLight = lightenColor(
    color: light,
    factor: 0.04,
  );

  static const black = Color(0xFF292928);
  static final grey = lightenColor(
    color: black,
    factor: 0.04,
  );

  ///
  /// DARK
  ///

  static const dark = Color(0xFF17293C);
  static final middleDark = lightenColor(
    color: dark,
    factor: 0.02,
  );
  static final lightDark = lightenColor(
    color: dark,
    factor: 0.04,
  );

  static const purple = Color(0xFF4F5090);

  ///
  /// NEUTRAL
  ///

  static const white = Color(0xFFFFFFFF);
  static const green = Color(0xFF417B5A);
  static const red = Color(0xFFED3B3B);
  static const blue = Color(0xFF016FB9);
  static const yellow = Color(0xFFFCC938);
  static const orange = Color(0xFFFF9505);
}

class BalunColorsExtension extends ThemeExtension<BalunColorsExtension> {
  final Color primaryBackground;
  final Color primaryBackgroundLight;
  final Color primaryForeground;
  final Color secondaryBackground;
  final Color accentLight;
  final Color accentStrong;
  final Color fixtureListTileBackground;
  final Color navigationBarBackground;
  final Color navigationBarItemBackground;
  final Color navigationBarItemSelectedBackground;
  final Color navigationBarIconColor;
  final Color datePickerActiveBackground;
  final Color datePickerInactiveBackground;
  final Color datePickerActiveIconColor;
  final Color datePickerInactiveIconColor;
  final Color slidingInfoPanelBackground;
  final Color matchField;
  final Color success;
  final Color danger;
  final Color info;
  final Color warning;
  final Color alert;

  BalunColorsExtension({
    required this.primaryBackground,
    required this.primaryBackgroundLight,
    required this.primaryForeground,
    required this.secondaryBackground,
    required this.accentLight,
    required this.accentStrong,
    required this.fixtureListTileBackground,
    required this.navigationBarBackground,
    required this.navigationBarItemBackground,
    required this.navigationBarItemSelectedBackground,
    required this.navigationBarIconColor,
    required this.datePickerActiveBackground,
    required this.datePickerInactiveBackground,
    required this.datePickerActiveIconColor,
    required this.datePickerInactiveIconColor,
    required this.slidingInfoPanelBackground,
    required this.matchField,
    required this.success,
    required this.danger,
    required this.info,
    required this.warning,
    required this.alert,
  });

  @override
  ThemeExtension<BalunColorsExtension> copyWith({
    Color? primaryBackground,
    Color? primaryBackgroundLight,
    Color? primaryForeground,
    Color? secondaryBackground,
    Color? accentLight,
    Color? accentStrong,
    Color? fixtureListTileBackground,
    Color? navigationBarBackground,
    Color? navigationBarItemBackground,
    Color? navigationBarItemSelectedBackground,
    Color? navigationBarIconColor,
    Color? datePickerActiveBackground,
    Color? datePickerInactiveBackground,
    Color? datePickerActiveIconColor,
    Color? datePickerInactiveIconColor,
    Color? slidingInfoPanelBackground,
    Color? matchField,
    Color? success,
    Color? danger,
    Color? info,
    Color? warning,
    Color? alert,
  }) => BalunColorsExtension(
    primaryBackground: primaryBackground ?? this.primaryBackground,
    primaryBackgroundLight: primaryBackgroundLight ?? this.primaryBackgroundLight,
    primaryForeground: primaryForeground ?? this.primaryForeground,
    secondaryBackground: secondaryBackground ?? this.secondaryBackground,
    accentLight: accentLight ?? this.accentLight,
    accentStrong: accentStrong ?? this.accentStrong,
    fixtureListTileBackground: fixtureListTileBackground ?? this.fixtureListTileBackground,
    navigationBarBackground: navigationBarBackground ?? this.navigationBarBackground,
    navigationBarItemBackground: navigationBarItemBackground ?? this.navigationBarItemBackground,
    navigationBarItemSelectedBackground: navigationBarItemSelectedBackground ?? this.navigationBarItemSelectedBackground,
    navigationBarIconColor: navigationBarIconColor ?? this.navigationBarIconColor,
    datePickerActiveBackground: datePickerActiveBackground ?? this.datePickerActiveBackground,
    datePickerInactiveBackground: datePickerInactiveBackground ?? this.datePickerInactiveBackground,
    datePickerActiveIconColor: datePickerActiveIconColor ?? this.datePickerActiveIconColor,
    datePickerInactiveIconColor: datePickerInactiveIconColor ?? this.datePickerInactiveIconColor,
    slidingInfoPanelBackground: slidingInfoPanelBackground ?? this.slidingInfoPanelBackground,
    matchField: matchField ?? this.matchField,
    success: success ?? this.success,
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
      primaryBackgroundLight: Color.lerp(primaryBackgroundLight, other.primaryBackgroundLight, t)!,
      primaryForeground: Color.lerp(primaryForeground, other.primaryForeground, t)!,
      secondaryBackground: Color.lerp(secondaryBackground, other.secondaryBackground, t)!,
      accentLight: Color.lerp(accentLight, other.accentLight, t)!,
      accentStrong: Color.lerp(accentStrong, other.accentStrong, t)!,
      fixtureListTileBackground: Color.lerp(fixtureListTileBackground, other.fixtureListTileBackground, t)!,
      navigationBarBackground: Color.lerp(navigationBarBackground, other.navigationBarBackground, t)!,
      navigationBarItemBackground: Color.lerp(navigationBarItemBackground, other.navigationBarItemBackground, t)!,
      navigationBarItemSelectedBackground: Color.lerp(navigationBarItemSelectedBackground, other.navigationBarItemSelectedBackground, t)!,
      navigationBarIconColor: Color.lerp(navigationBarIconColor, other.navigationBarIconColor, t)!,
      datePickerActiveBackground: Color.lerp(datePickerActiveBackground, other.datePickerActiveBackground, t)!,
      datePickerInactiveBackground: Color.lerp(datePickerInactiveBackground, other.datePickerInactiveBackground, t)!,
      datePickerActiveIconColor: Color.lerp(datePickerActiveIconColor, other.datePickerActiveIconColor, t)!,
      datePickerInactiveIconColor: Color.lerp(datePickerInactiveIconColor, other.datePickerInactiveIconColor, t)!,
      slidingInfoPanelBackground: Color.lerp(slidingInfoPanelBackground, other.slidingInfoPanelBackground, t)!,
      matchField: Color.lerp(matchField, other.matchField, t)!,
      success: Color.lerp(success, other.success, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      info: Color.lerp(info, other.info, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      alert: Color.lerp(alert, other.alert, t)!,
    );
  }
}
