import 'player_statistic_inner_cards.dart';
import 'player_statistic_inner_dribbles.dart';
import 'player_statistic_inner_duels.dart';
import 'player_statistic_inner_fouls.dart';
import 'player_statistic_inner_games.dart';
import 'player_statistic_inner_goals.dart';
import 'player_statistic_inner_passes.dart';
import 'player_statistic_inner_penalty.dart';
import 'player_statistic_inner_shots.dart';
import 'player_statistic_inner_tackles.dart';

class PlayerStatisticInner {
  final PlayerStatisticInnerGames? games;
  final int? offsides;
  final PlayerStatisticInnerShots? shots;
  final PlayerStatisticInnerGoals? goals;
  final PlayerStatisticInnerPasses? passes;
  final PlayerStatisticInnerTackles? tackles;
  final PlayerStatisticInnerDuels? duels;
  final PlayerStatisticInnerDribbles? dribbles;
  final PlayerStatisticInnerFouls? fouls;
  final PlayerStatisticInnerCards? cards;
  final PlayerStatisticInnerPenalty? penalty;

  PlayerStatisticInner({
    this.games,
    this.offsides,
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

  factory PlayerStatisticInner.fromMap(Map<String, dynamic> map) => PlayerStatisticInner(
        games: map['games'] != null ? PlayerStatisticInnerGames.fromMap(map['games'] as Map<String, dynamic>) : null,
        offsides: map['offsides'] != null ? map['offsides'] as int : null,
        shots: map['shots'] != null ? PlayerStatisticInnerShots.fromMap(map['shots'] as Map<String, dynamic>) : null,
        goals: map['goals'] != null ? PlayerStatisticInnerGoals.fromMap(map['goals'] as Map<String, dynamic>) : null,
        passes: map['passes'] != null ? PlayerStatisticInnerPasses.fromMap(map['passes'] as Map<String, dynamic>) : null,
        tackles: map['tackles'] != null ? PlayerStatisticInnerTackles.fromMap(map['tackles'] as Map<String, dynamic>) : null,
        duels: map['duels'] != null ? PlayerStatisticInnerDuels.fromMap(map['duels'] as Map<String, dynamic>) : null,
        dribbles: map['dribbles'] != null ? PlayerStatisticInnerDribbles.fromMap(map['dribbles'] as Map<String, dynamic>) : null,
        fouls: map['fouls'] != null ? PlayerStatisticInnerFouls.fromMap(map['fouls'] as Map<String, dynamic>) : null,
        cards: map['cards'] != null ? PlayerStatisticInnerCards.fromMap(map['cards'] as Map<String, dynamic>) : null,
        penalty: map['penalty'] != null ? PlayerStatisticInnerPenalty.fromMap(map['penalty'] as Map<String, dynamic>) : null,
      );

  @override
  String toString() =>
      'PlayerStatisticInner(games: $games, offsides: $offsides, shots: $shots, goals: $goals, passes: $passes, tackles: $tackles, duels: $duels, dribbles: $dribbles, fouls: $fouls, cards: $cards, penalty: $penalty)';

  @override
  bool operator ==(covariant PlayerStatisticInner other) {
    if (identical(this, other)) {
      return true;
    }

    return other.games == games &&
        other.offsides == offsides &&
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
      games.hashCode ^
      offsides.hashCode ^
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
