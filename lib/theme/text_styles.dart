import 'package:flutter/material.dart';

abstract class BalunTextStyles {
  static const fixturesMinute = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 26,
    fontWeight: FontWeight.w300,
  );

  static const fixturesName = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const fixturesScore = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 72,
    fontWeight: FontWeight.w300,
    height: 1,
  );

  static const matchLeagueName = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );

  static const matchLeagueRound = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const matchGoal = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const matchSectionTitle = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static const matchInfoSectionTitle = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const matchInfoSectionText = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
}

class BalunTextThemesExtension extends ThemeExtension<BalunTextThemesExtension> {
  final TextStyle fixturesMinute;
  final TextStyle fixturesName;
  final TextStyle fixturesScore;
  final TextStyle matchLeagueName;
  final TextStyle matchLeagueRound;
  final TextStyle matchGoal;
  final TextStyle matchSectionTitle;
  final TextStyle matchInfoSectionTitle;
  final TextStyle matchInfoSectionText;

  const BalunTextThemesExtension({
    required this.fixturesMinute,
    required this.fixturesName,
    required this.fixturesScore,
    required this.matchLeagueName,
    required this.matchLeagueRound,
    required this.matchGoal,
    required this.matchSectionTitle,
    required this.matchInfoSectionTitle,
    required this.matchInfoSectionText,
  });

  @override
  ThemeExtension<BalunTextThemesExtension> copyWith({
    TextStyle? fixturesMinute,
    TextStyle? fixturesName,
    TextStyle? fixturesScore,
    TextStyle? matchLeagueName,
    TextStyle? matchLeagueRound,
    TextStyle? matchGoal,
    TextStyle? matchSectionTitle,
    TextStyle? matchInfoSectionTitle,
    TextStyle? matchInfoSectionText,
  }) =>
      BalunTextThemesExtension(
        fixturesMinute: fixturesMinute ?? this.fixturesMinute,
        fixturesName: fixturesName ?? this.fixturesName,
        fixturesScore: fixturesScore ?? this.fixturesScore,
        matchLeagueName: matchLeagueName ?? this.matchLeagueName,
        matchLeagueRound: matchLeagueRound ?? this.matchLeagueRound,
        matchGoal: matchGoal ?? this.matchGoal,
        matchSectionTitle: matchSectionTitle ?? this.matchSectionTitle,
        matchInfoSectionTitle: matchInfoSectionTitle ?? this.matchInfoSectionTitle,
        matchInfoSectionText: matchInfoSectionText ?? this.matchInfoSectionText,
      );

  @override
  ThemeExtension<BalunTextThemesExtension> lerp(
    covariant ThemeExtension<BalunTextThemesExtension>? other,
    double t,
  ) {
    if (other is! BalunTextThemesExtension) {
      return this;
    }

    return BalunTextThemesExtension(
      fixturesMinute: TextStyle.lerp(fixturesMinute, other.fixturesMinute, t)!,
      fixturesName: TextStyle.lerp(fixturesName, other.fixturesName, t)!,
      fixturesScore: TextStyle.lerp(fixturesScore, other.fixturesScore, t)!,
      matchLeagueName: TextStyle.lerp(matchLeagueName, other.matchLeagueName, t)!,
      matchLeagueRound: TextStyle.lerp(matchLeagueRound, other.matchLeagueRound, t)!,
      matchGoal: TextStyle.lerp(matchGoal, other.matchGoal, t)!,
      matchSectionTitle: TextStyle.lerp(matchSectionTitle, other.matchSectionTitle, t)!,
      matchInfoSectionTitle: TextStyle.lerp(matchInfoSectionTitle, other.matchInfoSectionTitle, t)!,
      matchInfoSectionText: TextStyle.lerp(matchInfoSectionText, other.matchInfoSectionText, t)!,
    );
  }
}
