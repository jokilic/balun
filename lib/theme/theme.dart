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
        cursorColor: lightAppColors.accentStrong,
        selectionColor: lightAppColors.accentStrong,
        selectionHandleColor: lightAppColors.accentStrong,
      ),
      scaffoldBackgroundColor: lightAppColors.accentLight,
      extensions: [
        lightAppColors,
        lightTextTheme,
      ],
    );
  }

  static final lightAppColors = BalunColorsExtension(
    primaryBackground: BalunColors.white,
    primaryForeground: BalunColors.black,
    secondaryBackground: BalunColors.grey,
    accentLight: BalunColors.lightGreen,
    danger: BalunColors.red,
    accentStrong: BalunColors.darkGreen,
    info: BalunColors.blue,
    warning: BalunColors.yellow,
    alert: BalunColors.orange,
  );

  static final lightTextTheme = BalunTextThemesExtension(
    styles: {
      BalunTextStyleToken.displayXxl: BalunTextStyles.displayXxl.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.displayXl: BalunTextStyles.displayXl.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.headlineXl: BalunTextStyles.headlineXl.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.headlineXlLoose: BalunTextStyles.headlineXlLoose.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.headlineLgBold: BalunTextStyles.headlineLgBold.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.headlineLg: BalunTextStyles.headlineLg.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.headlineMdBold: BalunTextStyles.headlineMdBold.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.headlineMd: BalunTextStyles.headlineMd.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.headlineMdLight: BalunTextStyles.headlineMdLight.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.titleLgBoldTight: BalunTextStyles.titleLgBoldTight.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.titleLgBold: BalunTextStyles.titleLgBold.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.titleLgExtraBold: BalunTextStyles.titleLgExtraBold.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.titleLgLight: BalunTextStyles.titleLgLight.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.titleMdExtraBold: BalunTextStyles.titleMdExtraBold.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.titleMdBold: BalunTextStyles.titleMdBold.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.titleMd: BalunTextStyles.titleMd.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.titleMdLight: BalunTextStyles.titleMdLight.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.bodyLgExtraBold: BalunTextStyles.bodyLgExtraBold.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.bodyLgBoldLoose: BalunTextStyles.bodyLgBoldLoose.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.bodyLgBold: BalunTextStyles.bodyLgBold.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.bodyLgMedium: BalunTextStyles.bodyLgMedium.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.bodyLgTight: BalunTextStyles.bodyLgTight.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.bodyLg: BalunTextStyles.bodyLg.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.bodyLgLight: BalunTextStyles.bodyLgLight.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.bodyMdExtraBold: BalunTextStyles.bodyMdExtraBold.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.bodyMdBold: BalunTextStyles.bodyMdBold.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.bodyMd: BalunTextStyles.bodyMd.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.bodyMdLight: BalunTextStyles.bodyMdLight.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.labelBold: BalunTextStyles.labelBold.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.labelMedium: BalunTextStyles.labelMedium.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.label: BalunTextStyles.label.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.captionBold: BalunTextStyles.captionBold.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.caption: BalunTextStyles.caption.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.microBold: BalunTextStyles.microBold.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.micro: BalunTextStyles.micro.copyWith(
        color: lightAppColors.primaryForeground,
      ),
      BalunTextStyleToken.titleLgLightMuted: BalunTextStyles.titleLgLight.copyWith(
        color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.labelMuted: BalunTextStyles.label.copyWith(
        color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.labelMediumMuted: BalunTextStyles.labelMedium.copyWith(
        color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.bodyMdBoldMuted: BalunTextStyles.bodyMdBold.copyWith(
        color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.bodyLgBoldOnPrimary: BalunTextStyles.bodyLgBold.copyWith(
        color: lightAppColors.primaryBackground,
      ),
      BalunTextStyleToken.microBoldOnPrimary: BalunTextStyles.microBold.copyWith(
        color: lightAppColors.primaryBackground,
      ),
      BalunTextStyleToken.titleMdMuted: BalunTextStyles.titleMd.copyWith(
        color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.titleLgBoldMuted: BalunTextStyles.titleLgBold.copyWith(
        color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.bodyLgMediumMuted: BalunTextStyles.bodyLgMedium.copyWith(
        color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.bodyMdLightMuted: BalunTextStyles.bodyMdLight.copyWith(
        color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.labelBoldMuted: BalunTextStyles.labelBold.copyWith(
        color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.titleMdExtraBoldAccent: BalunTextStyles.titleMdExtraBold.copyWith(
        color: lightAppColors.accentStrong.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.bodyLgOnPrimary: BalunTextStyles.bodyLg.copyWith(
        color: lightAppColors.primaryBackground,
      ),
      BalunTextStyleToken.bodyLgMuted: BalunTextStyles.bodyLg.copyWith(
        color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
      ),
      BalunTextStyleToken.labelBoldOnPrimary: BalunTextStyles.labelBold.copyWith(
        color: lightAppColors.primaryBackground,
      ),
      BalunTextStyleToken.captionBoldOnPrimary: BalunTextStyles.captionBold.copyWith(
        color: lightAppColors.primaryBackground,
      ),
      BalunTextStyleToken.bodyLgTightMuted: BalunTextStyles.bodyLgTight.copyWith(
        color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
      ),
    },
  );
}

extension BalunThemeExtension on ThemeData {
  BalunColorsExtension get balunColors => extension<BalunColorsExtension>() ?? BalunTheme.lightAppColors;
  BalunTextThemesExtension get balunTextStyles => extension<BalunTextThemesExtension>() ?? BalunTheme.lightTextTheme;
}

extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
  BalunColorsExtension get colors => theme.balunColors;
  BalunTextThemesExtension get textStyles => theme.balunTextStyles;
}
