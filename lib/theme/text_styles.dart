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

  TextStyle resolve(BalunTextStyleToken token) => styles[token]!;

  TextStyle get displayXxl => resolve(BalunTextStyleToken.displayXxl);
  TextStyle get displayXl => resolve(BalunTextStyleToken.displayXl);
  TextStyle get headlineXl => resolve(BalunTextStyleToken.headlineXl);
  TextStyle get headlineXlLoose => resolve(BalunTextStyleToken.headlineXlLoose);
  TextStyle get headlineLgBold => resolve(BalunTextStyleToken.headlineLgBold);
  TextStyle get headlineLg => resolve(BalunTextStyleToken.headlineLg);
  TextStyle get headlineMdBold => resolve(BalunTextStyleToken.headlineMdBold);
  TextStyle get headlineMd => resolve(BalunTextStyleToken.headlineMd);
  TextStyle get headlineMdLight => resolve(BalunTextStyleToken.headlineMdLight);
  TextStyle get titleLgBoldTight => resolve(BalunTextStyleToken.titleLgBoldTight);
  TextStyle get titleLgBold => resolve(BalunTextStyleToken.titleLgBold);
  TextStyle get titleLgExtraBold => resolve(BalunTextStyleToken.titleLgExtraBold);
  TextStyle get titleLgLight => resolve(BalunTextStyleToken.titleLgLight);
  TextStyle get titleMdExtraBold => resolve(BalunTextStyleToken.titleMdExtraBold);
  TextStyle get titleMdBold => resolve(BalunTextStyleToken.titleMdBold);
  TextStyle get titleMd => resolve(BalunTextStyleToken.titleMd);
  TextStyle get titleMdLight => resolve(BalunTextStyleToken.titleMdLight);
  TextStyle get bodyLgExtraBold => resolve(BalunTextStyleToken.bodyLgExtraBold);
  TextStyle get bodyLgBoldLoose => resolve(BalunTextStyleToken.bodyLgBoldLoose);
  TextStyle get bodyLgBold => resolve(BalunTextStyleToken.bodyLgBold);
  TextStyle get bodyLgMedium => resolve(BalunTextStyleToken.bodyLgMedium);
  TextStyle get bodyLgTight => resolve(BalunTextStyleToken.bodyLgTight);
  TextStyle get bodyLg => resolve(BalunTextStyleToken.bodyLg);
  TextStyle get bodyLgLight => resolve(BalunTextStyleToken.bodyLgLight);
  TextStyle get bodyMdExtraBold => resolve(BalunTextStyleToken.bodyMdExtraBold);
  TextStyle get bodyMdBold => resolve(BalunTextStyleToken.bodyMdBold);
  TextStyle get bodyMd => resolve(BalunTextStyleToken.bodyMd);
  TextStyle get bodyMdLight => resolve(BalunTextStyleToken.bodyMdLight);
  TextStyle get labelBold => resolve(BalunTextStyleToken.labelBold);
  TextStyle get labelMedium => resolve(BalunTextStyleToken.labelMedium);
  TextStyle get label => resolve(BalunTextStyleToken.label);
  TextStyle get captionBold => resolve(BalunTextStyleToken.captionBold);
  TextStyle get caption => resolve(BalunTextStyleToken.caption);
  TextStyle get microBold => resolve(BalunTextStyleToken.microBold);
  TextStyle get micro => resolve(BalunTextStyleToken.micro);
  TextStyle get titleLgLightMuted => resolve(BalunTextStyleToken.titleLgLightMuted);
  TextStyle get labelMuted => resolve(BalunTextStyleToken.labelMuted);
  TextStyle get labelMediumMuted => resolve(BalunTextStyleToken.labelMediumMuted);
  TextStyle get bodyMdBoldMuted => resolve(BalunTextStyleToken.bodyMdBoldMuted);
  TextStyle get bodyLgBoldOnPrimary => resolve(BalunTextStyleToken.bodyLgBoldOnPrimary);
  TextStyle get microBoldOnPrimary => resolve(BalunTextStyleToken.microBoldOnPrimary);
  TextStyle get titleMdMuted => resolve(BalunTextStyleToken.titleMdMuted);
  TextStyle get titleLgBoldMuted => resolve(BalunTextStyleToken.titleLgBoldMuted);
  TextStyle get bodyLgMediumMuted => resolve(BalunTextStyleToken.bodyLgMediumMuted);
  TextStyle get bodyMdLightMuted => resolve(BalunTextStyleToken.bodyMdLightMuted);
  TextStyle get labelBoldMuted => resolve(BalunTextStyleToken.labelBoldMuted);
  TextStyle get titleMdExtraBoldAccent => resolve(BalunTextStyleToken.titleMdExtraBoldAccent);
  TextStyle get bodyLgOnPrimary => resolve(BalunTextStyleToken.bodyLgOnPrimary);
  TextStyle get bodyLgMuted => resolve(BalunTextStyleToken.bodyLgMuted);
  TextStyle get labelBoldOnPrimary => resolve(BalunTextStyleToken.labelBoldOnPrimary);
  TextStyle get captionBoldOnPrimary => resolve(BalunTextStyleToken.captionBoldOnPrimary);
  TextStyle get bodyLgTightMuted => resolve(BalunTextStyleToken.bodyLgTightMuted);

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
      lerped[token] = TextStyle.lerp(resolve(token), other.resolve(token), t)!;
    }

    return BalunTextThemesExtension(styles: lerped);
  }
}
