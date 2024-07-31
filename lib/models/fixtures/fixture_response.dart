import 'package:flutter/foundation.dart';

import 'event/event.dart';
import 'fixture/fixture.dart';
import 'goals/goals.dart';
import 'league/league.dart';
import 'lineup/lineup.dart';
import 'player_statistic/player_statistic.dart';
import 'score/score.dart';
import 'statistic/statistic.dart';
import 'teams/teams.dart';

class FixtureResponse {
  final Fixture? fixture;
  final League? league;
  final Teams? teams;
  final Goals? goals;
  final Score? score;
  final List<Event>? events;
  final List<Lineup>? lineups;
  final List<Statistic>? statistics;
  final List<PlayerStatistic>? playerStatistics;

  FixtureResponse({
    this.fixture,
    this.league,
    this.teams,
    this.goals,
    this.score,
    this.events,
    this.lineups,
    this.statistics,
    this.playerStatistics,
  });

  factory FixtureResponse.fromMap(Map<String, dynamic> map) => FixtureResponse(
        fixture: map['fixture'] != null ? Fixture.fromMap(map['fixture'] as Map<String, dynamic>) : null,
        league: map['league'] != null ? League.fromMap(map['league'] as Map<String, dynamic>) : null,
        teams: map['teams'] != null ? Teams.fromMap(map['teams'] as Map<String, dynamic>) : null,
        goals: map['goals'] != null ? Goals.fromMap(map['goals'] as Map<String, dynamic>) : null,
        score: map['score'] != null ? Score.fromMap(map['score'] as Map<String, dynamic>) : null,
        events: map['events'] != null
            ? List<Event>.from(
                (map['events'] as List).map<Event?>(
                  (x) => Event.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
        lineups: map['lineups'] != null
            ? List<Lineup>.from(
                (map['lineups'] as List).map<Lineup?>(
                  (x) => Lineup.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
        statistics: map['statistics'] != null
            ? List<Statistic>.from(
                (map['statistics'] as List).map<Statistic?>(
                  (x) => Statistic.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
        playerStatistics: map['players'] != null
            ? List<PlayerStatistic>.from(
                (map['players'] as List).map<PlayerStatistic?>(
                  (x) => PlayerStatistic.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() =>
      'FixtureResponse(fixture: $fixture, league: $league, teams: $teams, goals: $goals, score: $score, events: $events, lineups: $lineups, statistics: $statistics, playerStatistics: $playerStatistics)';

  @override
  bool operator ==(covariant FixtureResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return other.fixture == fixture &&
        other.league == league &&
        other.teams == teams &&
        other.goals == goals &&
        other.score == score &&
        listEquals(other.events, events) &&
        listEquals(other.lineups, lineups) &&
        listEquals(other.statistics, statistics) &&
        listEquals(other.playerStatistics, playerStatistics);
  }

  @override
  int get hashCode =>
      fixture.hashCode ^ league.hashCode ^ teams.hashCode ^ goals.hashCode ^ score.hashCode ^ events.hashCode ^ lineups.hashCode ^ statistics.hashCode ^ playerStatistics.hashCode;
}
