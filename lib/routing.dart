import 'dart:developer';

import 'package:flutter/material.dart';

import 'screens/fixtures/fixtures_screen.dart';
import 'screens/league/league_screen.dart';
import 'screens/match/match_screen.dart';
import 'screens/team/team_screen.dart';
import 'util/navigation.dart';

/// Opens [FixturesScreen]
void openFixtures(BuildContext context) => pushScreen(
      const FixturesScreen(
        key: ValueKey('fixtures'),
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
      isCircularTransition: true,
    );

/// Opens [TeamScreen]
void openTeam(BuildContext context, {required int teamId}) => pushScreen(
      TeamScreen(
        teamId: teamId,
        key: ValueKey(teamId),
      ),
      context: context,
      isCircularTransition: true,
    );

/// Opens [LeagueScreen]
void openLeague(BuildContext context, {required int leagueId}) => pushScreen(
      LeagueScreen(
        leagueId: leagueId,
        key: ValueKey(leagueId),
      ),
      context: context,
      isCircularTransition: true,
    );

/// Opens [PlayerScreen]
void openPlayer(BuildContext context, {required int playerId}) {
  log('Open player -> $playerId');
  // pushScreen(
  //   PlayerScreen(playerId: playerId),
  //   context: context,
  //   isCircularTransition: true,
  // );
}

/// Opens [CoachScreen]
void openCoach(BuildContext context, {required int coachId}) {
  log('Open coach -> $coachId');
  // pushScreen(
  //   CoachScreen(coachId: coachId),
  //   context: context,
  //   isCircularTransition: true,
  // );
}

/// Opens [VenueScreen]
void openVenue(BuildContext context, {required int venueId}) {
  log('Open venue -> $venueId');
  // pushScreen(
  //   VenueScreen(venueId: venueId),
  //   context: context,
  //   isCircularTransition: true,
  // );
}
