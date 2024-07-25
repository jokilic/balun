import 'dart:developer';

import 'package:flutter/material.dart';

import 'screens/fixtures/fixtures_screen.dart';
import 'screens/match/match_screen.dart';
import 'screens/team/team_screen.dart';
import 'util/navigation.dart';

/// Opens [FixturesScreen]
void openFixtures(BuildContext context) => pushScreen(
      FixturesScreen(),
      context: context,
    );

/// Opens [MatchScreen]
void openMatch(BuildContext context, {required int matchId}) => pushScreen(
      MatchScreen(matchId: matchId),
      context: context,
      isCircularTransition: true,
    );

/// Opens [TeamScreen]
void openTeam(BuildContext context, {required int teamId}) => pushScreen(
      TeamScreen(teamId: teamId),
      context: context,
      isCircularTransition: true,
    );

/// Opens [VenueScreen]
void openVenue(BuildContext context, {required int venueId}) {
  log('Open venue -> $venueId');
  // pushScreen(
  //   VenueScreen(venueId: venueId),
  //   context: context,
  //   isCircularTransition: true,
  // );
}

/// Opens [LeagueScreen]
void openLeague(BuildContext context, {required int leagueId}) {
  log('Open league -> $leagueId');
  // pushScreen(
  //   LeagueScreen(leagueId: leagueId),
  //   context: context,
  //   isCircularTransition: true,
  // );
}
