import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles.dart';

class BalunTheme {
  ///
  /// LIGHT
  ///

  static ThemeData get light {
    final defaultTheme = ThemeData.light();

    return defaultTheme.copyWith(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: lightAppColors.accent,
        selectionColor: lightAppColors.accent,
        selectionHandleColor: lightAppColors.accent,
      ),
      scaffoldBackgroundColor: lightAppColors.accent,
      extensions: [
        lightAppColors,
        lightTextTheme,
      ],
    );
  }

  ///
  /// DARK
  ///

  static ThemeData get dark {
    final defaultTheme = ThemeData.dark();

    return defaultTheme.copyWith(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: darkAppColors.accent,
        selectionColor: darkAppColors.accent,
        selectionHandleColor: darkAppColors.accent,
      ),
      scaffoldBackgroundColor: darkAppColors.accent,
      extensions: [
        darkAppColors,
        darkTextTheme,
      ],
    );
  }

  ///
  /// WHITE
  ///

  static ThemeData get white {
    final defaultTheme = ThemeData.light();

    return defaultTheme.copyWith(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: whiteAppColors.accent,
        selectionColor: whiteAppColors.accent,
        selectionHandleColor: whiteAppColors.accent,
      ),
      scaffoldBackgroundColor: whiteAppColors.accent,
      extensions: [
        whiteAppColors,
        whiteTextTheme,
      ],
    );
  }

  ///
  /// DARK
  ///

  static ThemeData get blue {
    final defaultTheme = ThemeData.dark();

    return defaultTheme.copyWith(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: blueAppColors.accent,
        selectionColor: blueAppColors.accent,
        selectionHandleColor: blueAppColors.accent,
      ),
      scaffoldBackgroundColor: blueAppColors.accent,
      extensions: [
        blueAppColors,
        blueTextTheme,
      ],
    );
  }

  ///
  /// COLORS
  ///

  static final lightAppColors = BalunColorsExtension(
    primaryBackground: BalunColors.white,
    primaryBackgroundLight: BalunColors.lightLight,
    primaryForeground: BalunColors.black,
    secondaryBackground: BalunColors.grey,
    accent: BalunColors.light,
    fixtureListTileBackground: BalunColors.lightLight,
    navigationBarBackground: BalunColors.black,
    navigationBarItemBackground: BalunColors.grey,
    navigationBarItemSelectedBackground: BalunColors.green,
    navigationBarIconColor: BalunColors.white,
    datePickerActiveBackground: BalunColors.green,
    datePickerInactiveBackground: BalunColors.lightLight,
    datePickerActiveIconColor: BalunColors.white,
    datePickerInactiveIconColor: BalunColors.white,
    slidingInfoPanelBackground: BalunColors.white,
    matchField: BalunColors.green,
    goal: BalunColors.green,
    success: BalunColors.green,
    danger: BalunColors.red,
    info: BalunColors.blue,
    warning: BalunColors.yellow,
    alert: BalunColors.orange,
  );

  static final darkAppColors = BalunColorsExtension(
    primaryBackground: BalunColors.dark,
    primaryBackgroundLight: BalunColors.purple.withValues(alpha: 0.4),
    primaryForeground: BalunColors.white,
    secondaryBackground: BalunColors.middleDark,
    accent: BalunColors.dark,
    fixtureListTileBackground: BalunColors.middleDark,
    navigationBarBackground: BalunColors.lightDark,
    navigationBarItemBackground: BalunColors.middleDark.withValues(alpha: 0.4),
    navigationBarItemSelectedBackground: BalunColors.purple,
    navigationBarIconColor: BalunColors.white,
    datePickerActiveBackground: BalunColors.purple,
    datePickerInactiveBackground: BalunColors.middleDark,
    datePickerActiveIconColor: BalunColors.white,
    datePickerInactiveIconColor: BalunColors.white,
    slidingInfoPanelBackground: BalunColors.middleDark,
    matchField: BalunColors.middleDark,
    goal: BalunColors.purple,
    success: BalunColors.green,
    danger: BalunColors.red,
    info: BalunColors.blue,
    warning: BalunColors.yellow,
    alert: BalunColors.orange,
  );

  static final whiteAppColors = BalunColorsExtension(
    primaryBackground: BalunColors.whiteThemeColor,
    primaryBackgroundLight: BalunColors.lightWhite,
    primaryForeground: BalunColors.black,
    secondaryBackground: BalunColors.grey,
    accent: BalunColors.whiteThemeColor,
    fixtureListTileBackground: BalunColors.lightWhite,
    navigationBarBackground: BalunColors.middleWhite,
    navigationBarItemBackground: BalunColors.lightWhite,
    navigationBarItemSelectedBackground: BalunColors.greenWhiteTheme,
    navigationBarIconColor: BalunColors.black,
    datePickerActiveBackground: BalunColors.greenWhiteTheme,
    datePickerInactiveBackground: BalunColors.lightWhite,
    datePickerActiveIconColor: BalunColors.black,
    datePickerInactiveIconColor: BalunColors.black,
    slidingInfoPanelBackground: BalunColors.whiteThemeColor,
    matchField: BalunColors.greenWhiteTheme,
    goal: BalunColors.greenWhiteTheme,
    success: BalunColors.green,
    danger: BalunColors.red,
    info: BalunColors.blue,
    warning: BalunColors.yellow,
    alert: BalunColors.orange,
  );

  static final blueAppColors = BalunColorsExtension(
    primaryBackground: BalunColors.blueThemeColor,
    primaryBackgroundLight: BalunColors.yellowBlueTheme,
    primaryForeground: BalunColors.white,
    secondaryBackground: BalunColors.middleBlue,
    accent: BalunColors.blueThemeColor,
    fixtureListTileBackground: BalunColors.middleBlue,
    navigationBarBackground: BalunColors.lightBlue,
    navigationBarItemBackground: BalunColors.middleBlue.withValues(alpha: 0.4),
    navigationBarItemSelectedBackground: BalunColors.yellowBlueTheme,
    navigationBarIconColor: BalunColors.white,
    datePickerActiveBackground: BalunColors.yellowBlueTheme,
    datePickerInactiveBackground: BalunColors.middleBlue,
    datePickerActiveIconColor: BalunColors.white,
    datePickerInactiveIconColor: BalunColors.white,
    slidingInfoPanelBackground: BalunColors.middleBlue,
    matchField: BalunColors.middleBlue,
    goal: BalunColors.yellowBlueTheme,
    success: BalunColors.green,
    danger: BalunColors.red,
    info: BalunColors.blue,
    warning: BalunColors.yellow,
    alert: BalunColors.orange,
  );

  ///
  /// TEXT THEMES
  ///

  static final lightTextTheme = buildTextTheme(
    lightAppColors,
    onPrimaryColor: lightAppColors.primaryBackground,
  );

  static final darkTextTheme = buildTextTheme(
    darkAppColors,
    onPrimaryColor: darkAppColors.primaryForeground,
  );

  static final whiteTextTheme = buildTextTheme(
    whiteAppColors,
    onPrimaryColor: whiteAppColors.primaryForeground,
  );

  static final blueTextTheme = buildTextTheme(
    blueAppColors,
    onPrimaryColor: blueAppColors.primaryForeground,
  );

  ///
  /// METHODS
  ///

  static BalunTextThemesExtension buildTextTheme(
    BalunColorsExtension colors, {
    required Color onPrimaryColor,
  }) => BalunTextThemesExtension(
    styles: {
      BalunTextStyleToken.displayXxl: BalunTextStyles.displayXxl.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.displayXl: BalunTextStyles.displayXl.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.headlineXl: BalunTextStyles.headlineXl.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.headlineXlLoose: BalunTextStyles.headlineXlLoose.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.headlineLgBold: BalunTextStyles.headlineLgBold.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.headlineLg: BalunTextStyles.headlineLg.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.headlineMdBold: BalunTextStyles.headlineMdBold.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.headlineMd: BalunTextStyles.headlineMd.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.headlineMdLight: BalunTextStyles.headlineMdLight.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.titleLgBoldTight: BalunTextStyles.titleLgBoldTight.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.titleLgBold: BalunTextStyles.titleLgBold.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.titleLgExtraBold: BalunTextStyles.titleLgExtraBold.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.titleLgLight: BalunTextStyles.titleLgLight.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.titleMdExtraBold: BalunTextStyles.titleMdExtraBold.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.titleMdBold: BalunTextStyles.titleMdBold.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.titleMd: BalunTextStyles.titleMd.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.titleMdLight: BalunTextStyles.titleMdLight.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.bodyLgExtraBold: BalunTextStyles.bodyLgExtraBold.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.bodyLgBoldLoose: BalunTextStyles.bodyLgBoldLoose.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.bodyLgBold: BalunTextStyles.bodyLgBold.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.bodyLgMedium: BalunTextStyles.bodyLgMedium.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.bodyLgTight: BalunTextStyles.bodyLgTight.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.bodyLg: BalunTextStyles.bodyLg.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.bodyLgLight: BalunTextStyles.bodyLgLight.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.bodyMdExtraBold: BalunTextStyles.bodyMdExtraBold.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.bodyMdBold: BalunTextStyles.bodyMdBold.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.bodyMd: BalunTextStyles.bodyMd.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.bodyMdLight: BalunTextStyles.bodyMdLight.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.labelBold: BalunTextStyles.labelBold.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.labelMedium: BalunTextStyles.labelMedium.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.label: BalunTextStyles.label.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.captionBold: BalunTextStyles.captionBold.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.caption: BalunTextStyles.caption.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.microBold: BalunTextStyles.microBold.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.micro: BalunTextStyles.micro.copyWith(
        color: colors.primaryForeground,
      ),
      BalunTextStyleToken.titleLgLightMuted: BalunTextStyles.titleLgLight.copyWith(
        color: colors.primaryForeground.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.labelMuted: BalunTextStyles.label.copyWith(
        color: colors.primaryForeground.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.labelMediumMuted: BalunTextStyles.labelMedium.copyWith(
        color: colors.primaryForeground.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.bodyMdBoldMuted: BalunTextStyles.bodyMdBold.copyWith(
        color: colors.primaryForeground.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.bodyLgBoldOnPrimary: BalunTextStyles.bodyLgBold.copyWith(
        color: onPrimaryColor,
      ),
      BalunTextStyleToken.microBoldOnPrimary: BalunTextStyles.microBold.copyWith(
        color: onPrimaryColor,
      ),
      BalunTextStyleToken.titleMdMuted: BalunTextStyles.titleMd.copyWith(
        color: colors.primaryForeground.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.titleLgBoldMuted: BalunTextStyles.titleLgBold.copyWith(
        color: colors.primaryForeground.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.bodyLgMediumMuted: BalunTextStyles.bodyLgMedium.copyWith(
        color: colors.primaryForeground.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.bodyMdLightMuted: BalunTextStyles.bodyMdLight.copyWith(
        color: colors.primaryForeground.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.labelBoldMuted: BalunTextStyles.labelBold.copyWith(
        color: colors.primaryForeground.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.titleMdExtraBoldAccent: BalunTextStyles.titleMdExtraBold.copyWith(
        color: onPrimaryColor,
      ),
      BalunTextStyleToken.bodyLgOnPrimary: BalunTextStyles.bodyLg.copyWith(
        color: onPrimaryColor,
      ),
      BalunTextStyleToken.bodyLgMuted: BalunTextStyles.bodyLg.copyWith(
        color: colors.primaryForeground.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.labelBoldOnPrimary: BalunTextStyles.labelBold.copyWith(
        color: onPrimaryColor,
      ),
      BalunTextStyleToken.captionBoldOnPrimary: BalunTextStyles.captionBold.copyWith(
        color: onPrimaryColor,
      ),
      BalunTextStyleToken.bodyLgTightMuted: BalunTextStyles.bodyLgTight.copyWith(
        color: colors.primaryForeground.withValues(alpha: 0.5),
      ),
    },
  );
}

///
/// EXTENSIONS
///

extension BalunThemeExtension on ThemeData {
  BalunColorsExtension get balunColors => extension<BalunColorsExtension>() ?? BalunTheme.lightAppColors;
  BalunTextThemesExtension get balunTextStyles => extension<BalunTextThemesExtension>() ?? BalunTheme.lightTextTheme;
}

extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
  BalunColorsExtension get colors => theme.balunColors;
  BalunTextThemesExtension get textStyles => theme.balunTextStyles;
}
