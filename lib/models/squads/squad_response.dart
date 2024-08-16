import 'package:flutter/foundation.dart';

import 'player/player.dart';
import 'team/team.dart';

class SquadResponse {
  final Team? team;
  final List<Player>? players;

  SquadResponse({
    this.team,
    this.players,
  });

  factory SquadResponse.fromMap(Map<String, dynamic> map) => SquadResponse(
        team: map['team'] != null ? Team.fromMap(map['team'] as Map<String, dynamic>) : null,
        players: map['players'] != null
            ? List<Player>.from(
                (map['players'] as List).map<Player?>(
                  (x) => Player.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'SquadResponse(team: $team, players: $players)';

  @override
  bool operator ==(covariant SquadResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return other.team == team && listEquals(other.players, players);
  }

  @override
  int get hashCode => team.hashCode ^ players.hashCode;
}
