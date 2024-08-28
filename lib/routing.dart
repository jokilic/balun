import 'dart:developer';

import 'package:flutter/material.dart';

import 'screens/coach/coach_screen.dart';
import 'screens/countries/countries_screen.dart';
import 'screens/fixtures/fixtures_screen.dart';
import 'screens/league/league_screen.dart';
import 'screens/leagues/leagues_screen.dart';
import 'screens/match/match_screen.dart';
import 'screens/player/player_screen.dart';
import 'screens/search/search_screen.dart';
import 'screens/team/team_screen.dart';
import 'util/navigation.dart';

/// Opens [FixturesScreen]
void openFixtures(BuildContext context) => pushScreen(
      const FixturesScreen(
        key: ValueKey('fixtures'),
      ),
      context: context,
    );

/// Opens [CountriesScreen]
void openCountries(BuildContext context) => pushScreen(
      const CountriesScreen(
        key: ValueKey('countries'),
      ),
      context: context,
    );

/// Opens [SearchScreen]
void openSearch(BuildContext context) => pushScreen(
      const SearchScreen(
        key: ValueKey('search'),
      ),
      context: context,
    );

/// Opens [LeaguesScreen]
void openLeagues(BuildContext context, {required String country}) => pushScreen(
      LeaguesScreen(
        country: country,
        key: ValueKey(country),
      ),
      context: context,
    );

/// Opens [MatchScreen]
void openMatch(BuildContext context, {required int matchId}) => pushScreen(
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
  required int season,
}) =>
    pushScreen(
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
  required int season,
}) =>
    pushScreen(
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
  required int season,
}) =>
    pushScreen(
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

/// Opens [VenueScreen]
void openVenue(BuildContext context, {required int venueId}) {
  log('Open venue -> $venueId');
  // pushScreen(
  //   VenueScreen(venueId: venueId),
  //   context: context,
  // );
}
