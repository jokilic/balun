import 'package:flutter/material.dart';

import 'screens/about/about_screen.dart';
import 'screens/coach/coach_screen.dart';
import 'screens/favorites/favorites_screen.dart';
import 'screens/language/language_screen.dart';
import 'screens/league/league_screen.dart';
import 'screens/leagues/leagues_screen.dart';
import 'screens/match/match_screen.dart';
import 'screens/notifications/notifications_screen.dart';
import 'screens/player/player_screen.dart';
import 'screens/status/status_screen.dart';
import 'screens/team/team_screen.dart';
import 'screens/theme/theme_screen.dart';
import 'util/navigation.dart';

/// Opens [ThemeScreen]
void openTheme(BuildContext context) => pushScreen(
  const ThemeScreen(
    key: ValueKey('theme'),
  ),
  context: context,
);

/// Opens [LanguageScreen]
void openLanguage(BuildContext context) => pushScreen(
  const LanguageScreen(
    key: ValueKey('language'),
  ),
  context: context,
);

/// Opens [NotificationsScreen]
void openNotifications(BuildContext context) => pushScreen(
  const NotificationsScreen(
    key: ValueKey('notifications'),
  ),
  context: context,
);

/// Opens [StatusScreen]
void openStatus(BuildContext context) => pushScreen(
  const StatusScreen(
    key: ValueKey('status'),
  ),
  context: context,
);

/// Opens [FavoritesScreen]
void openFavorites(BuildContext context) => pushScreen(
  const FavoritesScreen(
    key: ValueKey('favorites'),
  ),
  context: context,
);

/// Opens [AboutScreen]
void openAbout(BuildContext context) => pushScreen(
  const AboutScreen(
    key: ValueKey('about'),
  ),
  context: context,
);

/// Opens [LeaguesScreen]
void openLeagues(
  BuildContext context, {
  required String country,
}) => pushScreen(
  LeaguesScreen(
    country: country,
    key: ValueKey(country),
  ),
  context: context,
);

/// Opens [MatchScreen]
void openMatch(
  BuildContext context, {
  required int matchId,
}) => pushScreen(
  MatchScreen(
    matchId: matchId,
    key: ValueKey(matchId),
  ),
  context: context,
);

/// Opens [TeamScreen]
void openTeam(
  BuildContext context, {
  required int teamId,
  required String season,
}) => pushScreen(
  TeamScreen(
    teamId: teamId,
    season: season,
    key: ValueKey(teamId),
  ),
  context: context,
);

/// Opens [LeagueScreen]
void openLeague(
  BuildContext context, {
  required int leagueId,
  required String season,
}) => pushScreen(
  LeagueScreen(
    leagueId: leagueId,
    season: season,
    key: ValueKey(leagueId),
  ),
  context: context,
);

/// Opens [PlayerScreen]
void openPlayer(
  BuildContext context, {
  required int playerId,
  required String season,
}) => pushScreen(
  PlayerScreen(
    playerId: playerId,
    season: season,
    key: ValueKey(playerId),
  ),
  context: context,
);

/// Opens [CoachScreen]
void openCoach(BuildContext context, {required int coachId}) => pushScreen(
  CoachScreen(
    coachId: coachId,
    key: ValueKey(coachId),
  ),
  context: context,
);
