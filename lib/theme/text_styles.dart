import 'package:flutter/material.dart';

abstract class BalunTextStyles {
  static const error = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );

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
    fontSize: 18,
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

  static const matchStandingsSectionTitle = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  static const matchStandingsSectionText = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const matchStandingsSectionTextAlternate = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static const matchStandingsSectionForm = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const matchEventsSectionTime = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const matchEventsSectionText = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 18,
    fontWeight: FontWeight.w300,
  );

  static const matchEventsSectionResult = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const matchLineupsSectionTitle = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const matchLineupsSectionText = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const matchLineupsSectionTextSmall = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const matchLineupsSectionPlayer = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static const matchLineupsSectionNumber = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const matchStatisticsSectionText = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static const matchStatisticsSectionNumber = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 26,
    fontWeight: FontWeight.w600,
  );

  static const matchPlayerStatisticsName = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static const matchPlayerStatisticsTitle = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );

  static const matchPlayerStatisticsText = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const matchPlayerStatisticsValue = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const matchPlayerStatisticsRating = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const matchH2HScore = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 40,
    fontWeight: FontWeight.w300,
    height: 1,
  );

  static const matchH2HTitle = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const matchH2HText = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const leagueName = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  static const leagueCountry = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static const leagueSeason = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const leagueSeasonDropdown = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 22,
    fontWeight: FontWeight.w400,
  );

  static const leagueCountryName = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const leagueTeamsTitle = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );

  static const leagueTeamsCountry = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const leagueTeamsFounded = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const leagueFixturesTitle = TextStyle(
    fontFamily: 'Lufga',
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );
}

class BalunTextThemesExtension extends ThemeExtension<BalunTextThemesExtension> {
  final TextStyle error;
  final TextStyle fixturesMinute;
  final TextStyle fixturesName;
  final TextStyle fixturesScore;
  final TextStyle matchLeagueName;
  final TextStyle matchLeagueRound;
  final TextStyle matchGoal;
  final TextStyle matchSectionTitle;
  final TextStyle matchInfoSectionTitle;
  final TextStyle matchInfoSectionText;
  final TextStyle matchStandingsSectionTitle;
  final TextStyle matchStandingsSectionText;
  final TextStyle matchStandingsSectionTextAlternate;
  final TextStyle matchStandingsSectionForm;
  final TextStyle matchEventsSectionTime;
  final TextStyle matchEventsSectionText;
  final TextStyle matchEventsSectionResult;
  final TextStyle matchLineupsSectionTitle;
  final TextStyle matchLineupsSectionText;
  final TextStyle matchLineupsSectionTextSmall;
  final TextStyle matchLineupsSectionPlayer;
  final TextStyle matchLineupsSectionNumber;
  final TextStyle matchStatisticsSectionText;
  final TextStyle matchStatisticsSectionNumber;
  final TextStyle matchPlayerStatisticsName;
  final TextStyle matchPlayerStatisticsTitle;
  final TextStyle matchPlayerStatisticsText;
  final TextStyle matchPlayerStatisticsValue;
  final TextStyle matchPlayerStatisticsRating;
  final TextStyle matchH2HScore;
  final TextStyle matchH2HTitle;
  final TextStyle matchH2HText;
  final TextStyle leagueName;
  final TextStyle leagueCountry;
  final TextStyle leagueSeason;
  final TextStyle leagueSeasonDropdown;
  final TextStyle leagueTeamsTitle;
  final TextStyle leagueTeamsCountry;
  final TextStyle leagueTeamsFounded;
  final TextStyle leagueFixturesTitle;

  const BalunTextThemesExtension({
    required this.error,
    required this.fixturesMinute,
    required this.fixturesName,
    required this.fixturesScore,
    required this.matchLeagueName,
    required this.matchLeagueRound,
    required this.matchGoal,
    required this.matchSectionTitle,
    required this.matchInfoSectionTitle,
    required this.matchInfoSectionText,
    required this.matchStandingsSectionTitle,
    required this.matchStandingsSectionText,
    required this.matchStandingsSectionTextAlternate,
    required this.matchStandingsSectionForm,
    required this.matchEventsSectionTime,
    required this.matchEventsSectionText,
    required this.matchEventsSectionResult,
    required this.matchLineupsSectionTitle,
    required this.matchLineupsSectionText,
    required this.matchLineupsSectionTextSmall,
    required this.matchLineupsSectionPlayer,
    required this.matchLineupsSectionNumber,
    required this.matchStatisticsSectionText,
    required this.matchStatisticsSectionNumber,
    required this.matchPlayerStatisticsName,
    required this.matchPlayerStatisticsTitle,
    required this.matchPlayerStatisticsText,
    required this.matchPlayerStatisticsValue,
    required this.matchPlayerStatisticsRating,
    required this.matchH2HScore,
    required this.matchH2HTitle,
    required this.matchH2HText,
    required this.leagueName,
    required this.leagueCountry,
    required this.leagueSeason,
    required this.leagueSeasonDropdown,
    required this.leagueTeamsTitle,
    required this.leagueTeamsCountry,
    required this.leagueTeamsFounded,
    required this.leagueFixturesTitle,
  });

  @override
  ThemeExtension<BalunTextThemesExtension> copyWith({
    TextStyle? error,
    TextStyle? fixturesMinute,
    TextStyle? fixturesName,
    TextStyle? fixturesScore,
    TextStyle? matchLeagueName,
    TextStyle? matchLeagueRound,
    TextStyle? matchGoal,
    TextStyle? matchSectionTitle,
    TextStyle? matchInfoSectionTitle,
    TextStyle? matchInfoSectionText,
    TextStyle? matchStandingsSectionTitle,
    TextStyle? matchStandingsSectionText,
    TextStyle? matchStandingsSectionTextAlternate,
    TextStyle? matchStandingsSectionForm,
    TextStyle? matchEventsSectionTime,
    TextStyle? matchEventsSectionText,
    TextStyle? matchEventsSectionResult,
    TextStyle? matchLineupsSectionTitle,
    TextStyle? matchLineupsSectionText,
    TextStyle? matchLineupsSectionTextSmall,
    TextStyle? matchLineupsSectionPlayer,
    TextStyle? matchLineupsSectionNumber,
    TextStyle? matchStatisticsSectionText,
    TextStyle? matchStatisticsSectionNumber,
    TextStyle? matchPlayerStatisticsName,
    TextStyle? matchPlayerStatisticsTitle,
    TextStyle? matchPlayerStatisticsText,
    TextStyle? matchPlayerStatisticsValue,
    TextStyle? matchPlayerStatisticsRating,
    TextStyle? matchH2HScore,
    TextStyle? matchH2HTitle,
    TextStyle? matchH2HText,
    TextStyle? leagueName,
    TextStyle? leagueCountry,
    TextStyle? leagueSeason,
    TextStyle? leagueSeasonDropdown,
    TextStyle? leagueTeamsTitle,
    TextStyle? leagueTeamsCountry,
    TextStyle? leagueTeamsFounded,
    TextStyle? leagueFixturesTitle,
  }) =>
      BalunTextThemesExtension(
        error: error ?? this.error,
        fixturesMinute: fixturesMinute ?? this.fixturesMinute,
        fixturesName: fixturesName ?? this.fixturesName,
        fixturesScore: fixturesScore ?? this.fixturesScore,
        matchLeagueName: matchLeagueName ?? this.matchLeagueName,
        matchLeagueRound: matchLeagueRound ?? this.matchLeagueRound,
        matchGoal: matchGoal ?? this.matchGoal,
        matchSectionTitle: matchSectionTitle ?? this.matchSectionTitle,
        matchInfoSectionTitle: matchInfoSectionTitle ?? this.matchInfoSectionTitle,
        matchInfoSectionText: matchInfoSectionText ?? this.matchInfoSectionText,
        matchStandingsSectionTitle: matchStandingsSectionTitle ?? this.matchStandingsSectionTitle,
        matchStandingsSectionText: matchStandingsSectionText ?? this.matchStandingsSectionText,
        matchStandingsSectionTextAlternate: matchStandingsSectionTextAlternate ?? this.matchStandingsSectionTextAlternate,
        matchStandingsSectionForm: matchStandingsSectionForm ?? this.matchStandingsSectionForm,
        matchEventsSectionTime: matchEventsSectionTime ?? this.matchEventsSectionTime,
        matchEventsSectionText: matchEventsSectionText ?? this.matchEventsSectionText,
        matchEventsSectionResult: matchEventsSectionResult ?? this.matchEventsSectionResult,
        matchLineupsSectionTitle: matchLineupsSectionTitle ?? this.matchLineupsSectionTitle,
        matchLineupsSectionText: matchLineupsSectionText ?? this.matchLineupsSectionText,
        matchLineupsSectionTextSmall: matchLineupsSectionTextSmall ?? this.matchLineupsSectionTextSmall,
        matchLineupsSectionPlayer: matchLineupsSectionPlayer ?? this.matchLineupsSectionPlayer,
        matchLineupsSectionNumber: matchLineupsSectionNumber ?? this.matchLineupsSectionNumber,
        matchStatisticsSectionText: matchStatisticsSectionText ?? this.matchStatisticsSectionText,
        matchStatisticsSectionNumber: matchStatisticsSectionNumber ?? this.matchStatisticsSectionNumber,
        matchPlayerStatisticsName: matchPlayerStatisticsName ?? this.matchPlayerStatisticsName,
        matchPlayerStatisticsTitle: matchPlayerStatisticsTitle ?? this.matchPlayerStatisticsTitle,
        matchPlayerStatisticsText: matchPlayerStatisticsText ?? this.matchPlayerStatisticsText,
        matchPlayerStatisticsValue: matchPlayerStatisticsValue ?? this.matchPlayerStatisticsValue,
        matchPlayerStatisticsRating: matchPlayerStatisticsRating ?? this.matchPlayerStatisticsRating,
        matchH2HScore: matchH2HScore ?? this.matchH2HScore,
        matchH2HTitle: matchH2HTitle ?? this.matchH2HTitle,
        matchH2HText: matchH2HText ?? this.matchH2HText,
        leagueName: leagueName ?? this.leagueName,
        leagueCountry: leagueCountry ?? this.leagueCountry,
        leagueSeason: leagueSeason ?? this.leagueSeason,
        leagueSeasonDropdown: leagueSeasonDropdown ?? this.leagueSeasonDropdown,
        leagueTeamsTitle: leagueTeamsTitle ?? this.leagueTeamsTitle,
        leagueTeamsCountry: leagueTeamsCountry ?? this.leagueTeamsCountry,
        leagueTeamsFounded: leagueTeamsFounded ?? this.leagueTeamsFounded,
        leagueFixturesTitle: leagueFixturesTitle ?? this.leagueFixturesTitle,
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
      error: TextStyle.lerp(error, other.error, t)!,
      fixturesMinute: TextStyle.lerp(fixturesMinute, other.fixturesMinute, t)!,
      fixturesName: TextStyle.lerp(fixturesName, other.fixturesName, t)!,
      fixturesScore: TextStyle.lerp(fixturesScore, other.fixturesScore, t)!,
      matchLeagueName: TextStyle.lerp(matchLeagueName, other.matchLeagueName, t)!,
      matchLeagueRound: TextStyle.lerp(matchLeagueRound, other.matchLeagueRound, t)!,
      matchGoal: TextStyle.lerp(matchGoal, other.matchGoal, t)!,
      matchSectionTitle: TextStyle.lerp(matchSectionTitle, other.matchSectionTitle, t)!,
      matchInfoSectionTitle: TextStyle.lerp(matchInfoSectionTitle, other.matchInfoSectionTitle, t)!,
      matchInfoSectionText: TextStyle.lerp(matchInfoSectionText, other.matchInfoSectionText, t)!,
      matchStandingsSectionTitle: TextStyle.lerp(matchStandingsSectionTitle, other.matchStandingsSectionTitle, t)!,
      matchStandingsSectionText: TextStyle.lerp(matchStandingsSectionText, other.matchStandingsSectionText, t)!,
      matchStandingsSectionTextAlternate: TextStyle.lerp(matchStandingsSectionTextAlternate, other.matchStandingsSectionTextAlternate, t)!,
      matchStandingsSectionForm: TextStyle.lerp(matchStandingsSectionForm, other.matchStandingsSectionForm, t)!,
      matchEventsSectionTime: TextStyle.lerp(matchEventsSectionTime, other.matchEventsSectionTime, t)!,
      matchEventsSectionText: TextStyle.lerp(matchEventsSectionText, other.matchEventsSectionText, t)!,
      matchEventsSectionResult: TextStyle.lerp(matchEventsSectionResult, other.matchEventsSectionResult, t)!,
      matchLineupsSectionTitle: TextStyle.lerp(matchLineupsSectionTitle, other.matchLineupsSectionTitle, t)!,
      matchLineupsSectionText: TextStyle.lerp(matchLineupsSectionText, other.matchLineupsSectionText, t)!,
      matchLineupsSectionTextSmall: TextStyle.lerp(matchLineupsSectionTextSmall, other.matchLineupsSectionTextSmall, t)!,
      matchLineupsSectionPlayer: TextStyle.lerp(matchLineupsSectionPlayer, other.matchLineupsSectionPlayer, t)!,
      matchLineupsSectionNumber: TextStyle.lerp(matchLineupsSectionNumber, other.matchLineupsSectionNumber, t)!,
      matchStatisticsSectionText: TextStyle.lerp(matchStatisticsSectionText, other.matchStatisticsSectionText, t)!,
      matchStatisticsSectionNumber: TextStyle.lerp(matchStatisticsSectionNumber, other.matchStatisticsSectionNumber, t)!,
      matchPlayerStatisticsName: TextStyle.lerp(matchPlayerStatisticsName, other.matchPlayerStatisticsName, t)!,
      matchPlayerStatisticsTitle: TextStyle.lerp(matchPlayerStatisticsTitle, other.matchPlayerStatisticsTitle, t)!,
      matchPlayerStatisticsText: TextStyle.lerp(matchPlayerStatisticsText, other.matchPlayerStatisticsText, t)!,
      matchPlayerStatisticsValue: TextStyle.lerp(matchPlayerStatisticsValue, other.matchPlayerStatisticsValue, t)!,
      matchPlayerStatisticsRating: TextStyle.lerp(matchPlayerStatisticsRating, other.matchPlayerStatisticsRating, t)!,
      matchH2HScore: TextStyle.lerp(matchH2HScore, other.matchH2HScore, t)!,
      matchH2HTitle: TextStyle.lerp(matchH2HTitle, other.matchH2HTitle, t)!,
      matchH2HText: TextStyle.lerp(matchH2HText, other.matchH2HText, t)!,
      leagueName: TextStyle.lerp(leagueName, other.leagueName, t)!,
      leagueCountry: TextStyle.lerp(leagueCountry, other.leagueCountry, t)!,
      leagueSeason: TextStyle.lerp(leagueSeason, other.leagueSeason, t)!,
      leagueSeasonDropdown: TextStyle.lerp(leagueSeasonDropdown, other.leagueSeasonDropdown, t)!,
      leagueTeamsTitle: TextStyle.lerp(leagueTeamsTitle, other.leagueTeamsTitle, t)!,
      leagueTeamsCountry: TextStyle.lerp(leagueTeamsCountry, other.leagueTeamsCountry, t)!,
      leagueTeamsFounded: TextStyle.lerp(leagueTeamsFounded, other.leagueTeamsFounded, t)!,
      leagueFixturesTitle: TextStyle.lerp(leagueFixturesTitle, other.leagueFixturesTitle, t)!,
    );
  }
}
