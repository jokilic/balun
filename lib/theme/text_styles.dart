import 'package:flutter/material.dart';

const fontFamily = 'Lufga';

class BalunTextStyles {
  static const displayXxl = TextStyle(
    fontFamily: fontFamily,
    fontSize: 56,
    fontWeight: FontWeight.w300,
    height: 1,
  );

  static const displayXl = TextStyle(
    fontFamily: fontFamily,
    fontSize: 40,
    fontWeight: FontWeight.w300,
    height: 1,
  );

  static const headlineXl = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  static const headlineXlLoose = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const headlineLgBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 26,
    fontWeight: FontWeight.w600,
  );

  static const headlineLg = TextStyle(
    fontFamily: fontFamily,
    fontSize: 26,
    fontWeight: FontWeight.w500,
  );

  static const headlineMdBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const headlineMd = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );

  static const headlineMdLight = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.2,
  );

  static const titleLgBoldTight = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1,
  );

  static const titleLgBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );

  static const titleLgExtraBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static const titleLgLight = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w300,
  );

  static const titleMdExtraBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static const titleMdBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const titleMd = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static const titleMdLight = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static const bodyLgExtraBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.6,
  );

  static const bodyLgBoldLoose = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.6,
  );

  static const bodyLgBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const bodyLgMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const bodyLgTight = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1,
  );

  static const bodyLg = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static const bodyLgLight = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w300,
  );

  static const bodyMdExtraBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const bodyMdBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const bodyMd = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const bodyMdLight = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const labelBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const label = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const captionBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static const caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1,
  );

  static const microBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );

  static const micro = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );
}

enum BalunTextStyleToken {
  displayXxl,
  displayXl,
  headlineXl,
  headlineXlLoose,
  headlineLgBold,
  headlineLg,
  headlineMdBold,
  headlineMd,
  headlineMdLight,
  titleLgBoldTight,
  titleLgBold,
  titleLgExtraBold,
  titleLgLight,
  titleMdExtraBold,
  titleMdBold,
  titleMd,
  titleMdLight,
  bodyLgExtraBold,
  bodyLgBoldLoose,
  bodyLgBold,
  bodyLgMedium,
  bodyLgTight,
  bodyLg,
  bodyLgLight,
  bodyMdExtraBold,
  bodyMdBold,
  bodyMd,
  bodyMdLight,
  labelBold,
  labelMedium,
  label,
  captionBold,
  caption,
  microBold,
  micro,
  titleLgLightMuted,
  labelMuted,
  labelMediumMuted,
  bodyMdBoldMuted,
  bodyLgBoldOnPrimary,
  microBoldOnPrimary,
  titleMdMuted,
  titleLgBoldMuted,
  bodyLgMediumMuted,
  bodyMdLightMuted,
  labelBoldMuted,
  titleMdExtraBoldAccent,
  bodyLgOnPrimary,
  bodyLgMuted,
  labelBoldOnPrimary,
  captionBoldOnPrimary,
  bodyLgTightMuted,
}

class BalunTextThemesExtension extends ThemeExtension<BalunTextThemesExtension> {
  final Map<BalunTextStyleToken, TextStyle> styles;

  BalunTextThemesExtension({
    required Map<BalunTextStyleToken, TextStyle> styles,
  }) : styles = Map.unmodifiable(styles);

  TextStyle _resolve(BalunTextStyleToken token) => styles[token]!;

  TextStyle get displayXxl => _resolve(BalunTextStyleToken.displayXxl);
  TextStyle get displayXl => _resolve(BalunTextStyleToken.displayXl);
  TextStyle get headlineXl => _resolve(BalunTextStyleToken.headlineXl);
  TextStyle get headlineXlLoose => _resolve(BalunTextStyleToken.headlineXlLoose);
  TextStyle get headlineLgBold => _resolve(BalunTextStyleToken.headlineLgBold);
  TextStyle get headlineLg => _resolve(BalunTextStyleToken.headlineLg);
  TextStyle get headlineMdBold => _resolve(BalunTextStyleToken.headlineMdBold);
  TextStyle get headlineMd => _resolve(BalunTextStyleToken.headlineMd);
  TextStyle get headlineMdLight => _resolve(BalunTextStyleToken.headlineMdLight);
  TextStyle get titleLgBoldTight => _resolve(BalunTextStyleToken.titleLgBoldTight);
  TextStyle get titleLgBold => _resolve(BalunTextStyleToken.titleLgBold);
  TextStyle get titleLgExtraBold => _resolve(BalunTextStyleToken.titleLgExtraBold);
  TextStyle get titleLgLight => _resolve(BalunTextStyleToken.titleLgLight);
  TextStyle get titleMdExtraBold => _resolve(BalunTextStyleToken.titleMdExtraBold);
  TextStyle get titleMdBold => _resolve(BalunTextStyleToken.titleMdBold);
  TextStyle get titleMd => _resolve(BalunTextStyleToken.titleMd);
  TextStyle get titleMdLight => _resolve(BalunTextStyleToken.titleMdLight);
  TextStyle get bodyLgExtraBold => _resolve(BalunTextStyleToken.bodyLgExtraBold);
  TextStyle get bodyLgBoldLoose => _resolve(BalunTextStyleToken.bodyLgBoldLoose);
  TextStyle get bodyLgBold => _resolve(BalunTextStyleToken.bodyLgBold);
  TextStyle get bodyLgMedium => _resolve(BalunTextStyleToken.bodyLgMedium);
  TextStyle get bodyLgTight => _resolve(BalunTextStyleToken.bodyLgTight);
  TextStyle get bodyLg => _resolve(BalunTextStyleToken.bodyLg);
  TextStyle get bodyLgLight => _resolve(BalunTextStyleToken.bodyLgLight);
  TextStyle get bodyMdExtraBold => _resolve(BalunTextStyleToken.bodyMdExtraBold);
  TextStyle get bodyMdBold => _resolve(BalunTextStyleToken.bodyMdBold);
  TextStyle get bodyMd => _resolve(BalunTextStyleToken.bodyMd);
  TextStyle get bodyMdLight => _resolve(BalunTextStyleToken.bodyMdLight);
  TextStyle get labelBold => _resolve(BalunTextStyleToken.labelBold);
  TextStyle get labelMedium => _resolve(BalunTextStyleToken.labelMedium);
  TextStyle get label => _resolve(BalunTextStyleToken.label);
  TextStyle get captionBold => _resolve(BalunTextStyleToken.captionBold);
  TextStyle get caption => _resolve(BalunTextStyleToken.caption);
  TextStyle get microBold => _resolve(BalunTextStyleToken.microBold);
  TextStyle get micro => _resolve(BalunTextStyleToken.micro);
  TextStyle get titleLgLightMuted => _resolve(BalunTextStyleToken.titleLgLightMuted);
  TextStyle get labelMuted => _resolve(BalunTextStyleToken.labelMuted);
  TextStyle get labelMediumMuted => _resolve(BalunTextStyleToken.labelMediumMuted);
  TextStyle get bodyMdBoldMuted => _resolve(BalunTextStyleToken.bodyMdBoldMuted);
  TextStyle get bodyLgBoldOnPrimary => _resolve(BalunTextStyleToken.bodyLgBoldOnPrimary);
  TextStyle get microBoldOnPrimary => _resolve(BalunTextStyleToken.microBoldOnPrimary);
  TextStyle get titleMdMuted => _resolve(BalunTextStyleToken.titleMdMuted);
  TextStyle get titleLgBoldMuted => _resolve(BalunTextStyleToken.titleLgBoldMuted);
  TextStyle get bodyLgMediumMuted => _resolve(BalunTextStyleToken.bodyLgMediumMuted);
  TextStyle get bodyMdLightMuted => _resolve(BalunTextStyleToken.bodyMdLightMuted);
  TextStyle get labelBoldMuted => _resolve(BalunTextStyleToken.labelBoldMuted);
  TextStyle get titleMdExtraBoldAccent => _resolve(BalunTextStyleToken.titleMdExtraBoldAccent);
  TextStyle get bodyLgOnPrimary => _resolve(BalunTextStyleToken.bodyLgOnPrimary);
  TextStyle get bodyLgMuted => _resolve(BalunTextStyleToken.bodyLgMuted);
  TextStyle get labelBoldOnPrimary => _resolve(BalunTextStyleToken.labelBoldOnPrimary);
  TextStyle get captionBoldOnPrimary => _resolve(BalunTextStyleToken.captionBoldOnPrimary);
  TextStyle get bodyLgTightMuted => _resolve(BalunTextStyleToken.bodyLgTightMuted);

  @override
  BalunTextThemesExtension copyWith({
    Map<BalunTextStyleToken, TextStyle>? styles,
  }) {
    if (styles == null || styles.isEmpty) {
      return this;
    }

    return BalunTextThemesExtension(
      styles: {
        ...this.styles,
        ...styles,
      },
    );
  }

  @override
  BalunTextThemesExtension lerp(
    covariant BalunTextThemesExtension? other,
    double t,
  ) {
    if (other == null) {
      return this;
    }

    final lerped = <BalunTextStyleToken, TextStyle>{};
    for (final token in BalunTextStyleToken.values) {
      lerped[token] = TextStyle.lerp(_resolve(token), other._resolve(token), t)!;
    }

    return BalunTextThemesExtension(styles: lerped);
  }
}
