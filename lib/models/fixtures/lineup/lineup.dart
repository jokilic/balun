import 'package:flutter/foundation.dart';

import 'lineup_coach.dart';
import 'lineup_player.dart';
import 'lineup_team.dart';

class Lineup {
  final LineupTeam? team;
  final String? formation;
  final List<LineupPlayer>? startXI;
  final List<LineupPlayer>? substitutes;
  final LineupCoach? coach;

  Lineup({
    this.team,
    this.formation,
    this.startXI,
    this.substitutes,
    this.coach,
  });

  factory Lineup.fromMap(Map<String, dynamic> map) => Lineup(
        team: map['team'] != null ? LineupTeam.fromMap(map['team'] as Map<String, dynamic>) : null,
        formation: map['formation'] != null ? map['formation'] as String : null,
        startXI: map['startXI'] != null
            ? List<LineupPlayer>.from(
                (map['startXI'] as List).map<LineupPlayer?>(
                  (x) => LineupPlayer.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
        substitutes: map['substitutes'] != null
            ? List<LineupPlayer>.from(
                (map['substitutes'] as List).map<LineupPlayer?>(
                  (x) => LineupPlayer.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
        coach: map['coach'] != null ? LineupCoach.fromMap(map['coach'] as Map<String, dynamic>) : null,
      );

  @override
  String toString() => 'Lineup(team: $team, formation: $formation, startXI: $startXI, substitutes: $substitutes, coach: $coach)';

  @override
  bool operator ==(covariant Lineup other) {
    if (identical(this, other)) {
      return true;
    }

    return other.team == team && other.formation == formation && listEquals(other.startXI, startXI) && listEquals(other.substitutes, substitutes) && other.coach == coach;
  }

  @override
  int get hashCode => team.hashCode ^ formation.hashCode ^ startXI.hashCode ^ substitutes.hashCode ^ coach.hashCode;
}
