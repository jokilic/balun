import 'statistic_cards.dart';
import 'statistic_dribbles.dart';
import 'statistic_duels.dart';
import 'statistic_fouls.dart';
import 'statistic_games.dart';
import 'statistic_goals.dart';
import 'statistic_league.dart';
import 'statistic_passes.dart';
import 'statistic_penalty.dart';
import 'statistic_shots.dart';
import 'statistic_substitutes.dart';
import 'statistic_tackles.dart';
import 'statistic_team.dart';

class Statistic {
  final StatisticTeam? team;
  final StatisticLeague? league;
  final StatisticGames? games;
  final StatisticSubstitutes? substitutes;
  final StatisticShots? shots;
  final StatisticGoals? goals;
  final StatisticPasses? passes;
  final StatisticTackles? tackles;
  final StatisticDuels? duels;
  final StatisticDribbles? dribbles;
  final StatisticFouls? fouls;
  final StatisticCards? cards;
  final StatisticPenalty? penalty;

  Statistic({
    this.team,
    this.league,
    this.games,
    this.substitutes,
    this.shots,
    this.goals,
    this.passes,
    this.tackles,
    this.duels,
    this.dribbles,
    this.fouls,
    this.cards,
    this.penalty,
  });

  factory Statistic.fromMap(Map<String, dynamic> map) => Statistic(
        team: map['team'] != null ? StatisticTeam.fromMap(map['team'] as Map<String, dynamic>) : null,
        league: map['league'] != null ? StatisticLeague.fromMap(map['league'] as Map<String, dynamic>) : null,
        games: map['games'] != null ? StatisticGames.fromMap(map['games'] as Map<String, dynamic>) : null,
        substitutes: map['substitutes'] != null ? StatisticSubstitutes.fromMap(map['substitutes'] as Map<String, dynamic>) : null,
        shots: map['shots'] != null ? StatisticShots.fromMap(map['shots'] as Map<String, dynamic>) : null,
        goals: map['goals'] != null ? StatisticGoals.fromMap(map['goals'] as Map<String, dynamic>) : null,
        passes: map['passes'] != null ? StatisticPasses.fromMap(map['passes'] as Map<String, dynamic>) : null,
        tackles: map['tackles'] != null ? StatisticTackles.fromMap(map['tackles'] as Map<String, dynamic>) : null,
        duels: map['duels'] != null ? StatisticDuels.fromMap(map['duels'] as Map<String, dynamic>) : null,
        dribbles: map['dribbles'] != null ? StatisticDribbles.fromMap(map['dribbles'] as Map<String, dynamic>) : null,
        fouls: map['fouls'] != null ? StatisticFouls.fromMap(map['fouls'] as Map<String, dynamic>) : null,
        cards: map['cards'] != null ? StatisticCards.fromMap(map['cards'] as Map<String, dynamic>) : null,
        penalty: map['penalty'] != null ? StatisticPenalty.fromMap(map['penalty'] as Map<String, dynamic>) : null,
      );

  @override
  String toString() =>
      'Statistic(team: $team, league: $league, games: $games, substitutes: $substitutes, shots: $shots, goals: $goals, passes: $passes, tackles: $tackles, duels: $duels, dribbles: $dribbles, fouls: $fouls, cards: $cards, penalty: $penalty)';

  @override
  bool operator ==(covariant Statistic other) {
    if (identical(this, other)) {
      return true;
    }

    return other.team == team &&
        other.league == league &&
        other.games == games &&
        other.substitutes == substitutes &&
        other.shots == shots &&
        other.goals == goals &&
        other.passes == passes &&
        other.tackles == tackles &&
        other.duels == duels &&
        other.dribbles == dribbles &&
        other.fouls == fouls &&
        other.cards == cards &&
        other.penalty == penalty;
  }

  @override
  int get hashCode =>
      team.hashCode ^
      league.hashCode ^
      games.hashCode ^
      substitutes.hashCode ^
      shots.hashCode ^
      goals.hashCode ^
      passes.hashCode ^
      tackles.hashCode ^
      duels.hashCode ^
      dribbles.hashCode ^
      fouls.hashCode ^
      cards.hashCode ^
      penalty.hashCode;
}
