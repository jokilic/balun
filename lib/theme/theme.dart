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
    error: BalunTextStyles.error.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    snackbar: BalunTextStyles.snackbar.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    fixturesCountry: BalunTextStyles.fixturesCountry.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    fixturesLeague: BalunTextStyles.fixturesLeague.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    fixturesMinute: BalunTextStyles.fixturesMinute.copyWith(
      color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
    ),
    fixturesMinuteExtra: BalunTextStyles.fixturesMinuteExtra.copyWith(
      color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
    ),
    fixturesName: BalunTextStyles.fixturesName.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    fixturesNameCompact: BalunTextStyles.fixturesNameCompact.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    fixturesScore: BalunTextStyles.fixturesScore.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    fixturesScoreCompact: BalunTextStyles.fixturesScoreCompact.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchLeagueName: BalunTextStyles.matchLeagueName.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchLeagueRound: BalunTextStyles.matchLeagueRound.copyWith(
      color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
    ),
    matchGoal: BalunTextStyles.matchGoal.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchSectionTitle: BalunTextStyles.matchSectionTitle.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchInfoSectionTitle: BalunTextStyles.matchInfoSectionTitle.copyWith(
      color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
    ),
    matchInfoSectionText: BalunTextStyles.matchInfoSectionText.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchInfoSectionBottomText: BalunTextStyles.matchInfoSectionBottomText.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchStandingsSectionTitle: BalunTextStyles.matchStandingsSectionTitle.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchStandingsSectionSubtitle: BalunTextStyles.matchStandingsSectionSubtitle.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchStandingsSectionText: BalunTextStyles.matchStandingsSectionText.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchStandingsSectionTextCompact: BalunTextStyles.matchStandingsSectionTextCompact.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchStandingsSectionForm: BalunTextStyles.matchStandingsSectionForm.copyWith(
      color: lightAppColors.primaryBackground,
    ),
    matchEventsSectionTime: BalunTextStyles.matchEventsSectionTime.copyWith(
      color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
    ),
    matchEventsSectionText: BalunTextStyles.matchEventsSectionText.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchEventsSectionResult: BalunTextStyles.matchEventsSectionResult.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchHighlightsVideoTitle: BalunTextStyles.matchHighlightsVideoTitle.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchHighlightsVideoChannel: BalunTextStyles.matchHighlightsVideoChannel.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchHighlightsVideoDescription: BalunTextStyles.matchHighlightsVideoDescription.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchHighlightsSimilarVideos: BalunTextStyles.matchHighlightsSimilarVideos.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchLineupsSectionTitle: BalunTextStyles.matchLineupsSectionTitle.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchLineupsSectionSubtitle: BalunTextStyles.matchLineupsSectionSubtitle.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchLineupsSectionText: BalunTextStyles.matchLineupsSectionText.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchLineupsSectionTextSmall: BalunTextStyles.matchLineupsSectionTextSmall.copyWith(
      color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
    ),
    matchLineupsSectionPlayer: BalunTextStyles.matchLineupsSectionPlayer.copyWith(
      color: lightAppColors.primaryBackground,
    ),
    matchLineupsSectionNumber: BalunTextStyles.matchLineupsSectionNumber.copyWith(
      color: lightAppColors.primaryBackground,
    ),
    matchStatisticsSectionText: BalunTextStyles.matchStatisticsSectionText.copyWith(
      color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
    ),
    matchStatisticsSectionNumber: BalunTextStyles.matchStatisticsSectionNumber.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchPlayerStatisticsName: BalunTextStyles.matchPlayerStatisticsName.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchPlayerStatisticsTitle: BalunTextStyles.matchPlayerStatisticsTitle.copyWith(
      color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
    ),
    matchPlayerStatisticsText: BalunTextStyles.matchPlayerStatisticsText.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchPlayerStatisticsValue: BalunTextStyles.matchPlayerStatisticsValue.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchPlayerStatisticsRating: BalunTextStyles.matchPlayerStatisticsRating.copyWith(
      color: lightAppColors.primaryBackground,
    ),
    matchH2HScore: BalunTextStyles.matchH2HScore.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchH2HTitle: BalunTextStyles.matchH2HTitle.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    matchH2HText: BalunTextStyles.matchH2HText.copyWith(
      color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
    ),
    leagueName: BalunTextStyles.leagueName.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    leagueNameBold: BalunTextStyles.leagueNameBold.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    leagueCountry: BalunTextStyles.leagueCountry.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    leagueSeason: BalunTextStyles.leagueSeason.copyWith(
      color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
    ),
    leagueTeamsTitle: BalunTextStyles.leagueTeamsTitle.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    leagueTeamsCountry: BalunTextStyles.leagueTeamsCountry.copyWith(
      color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
    ),
    leagueTeamsFounded: BalunTextStyles.leagueTeamsFounded.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    leagueFixturesTitle: BalunTextStyles.leagueFixturesTitle.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    teamLeaguesSeason: BalunTextStyles.teamLeaguesSeason.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    teamFounded: BalunTextStyles.teamFounded.copyWith(
      color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
    ),
    teamCoachCareerTeam: BalunTextStyles.teamCoachCareerTeam.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    teamCoachCareerTitle: BalunTextStyles.teamCoachCareerTitle.copyWith(
      color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
    ),
    teamCoachCareerValue: BalunTextStyles.teamCoachCareerValue.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    teamTransferTeam: BalunTextStyles.teamTransferTeam.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    fixtureDatePickerActive: BalunTextStyles.fixtureDatePickerActive.copyWith(
      color: lightAppColors.accentStrong.withValues(alpha: 0.5),
    ),
    fixtureDatePickerInactive: BalunTextStyles.fixtureDatePickerInactive.copyWith(
      color: lightAppColors.primaryBackground,
    ),
    seasonPickerActive: BalunTextStyles.seasonPickerActive.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    seasonPickerInactive: BalunTextStyles.seasonPickerInactive.copyWith(
      color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
    ),
    searchPickerActive: BalunTextStyles.searchPickerActive.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    searchPickerInactive: BalunTextStyles.searchPickerInactive.copyWith(
      color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
    ),
    searchTextField: BalunTextStyles.searchTextField.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    calendarDayActive: BalunTextStyles.calendarDayActive.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    calendarDayInactive: BalunTextStyles.calendarDayInactive.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    leaguesSubtitle: BalunTextStyles.leaguesSubtitle.copyWith(
      color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
    ),
    dialogButton: BalunTextStyles.dialogButton.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    dialogTitle: BalunTextStyles.dialogTitle.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    dialogText: BalunTextStyles.dialogText.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    dialogSubtitle: BalunTextStyles.dialogSubtitle.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    badgeNumber: BalunTextStyles.badgeNumber.copyWith(
      color: lightAppColors.primaryBackground,
    ),
    matchLineupRating: BalunTextStyles.matchLineupRating.copyWith(
      color: lightAppColors.primaryBackground,
    ),
    newsDateTime: BalunTextStyles.newsDateTime.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    newsTwoLetterSource: BalunTextStyles.newsTwoLetterSource.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    aboutAppName: BalunTextStyles.aboutAppName.copyWith(
      color: lightAppColors.primaryForeground,
    ),
    aboutAppVersion: BalunTextStyles.aboutAppVersion.copyWith(
      color: lightAppColors.primaryForeground.withValues(alpha: 0.5),
    ),
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
