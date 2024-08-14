import 'package:flutter/foundation.dart';

import 'player/player.dart';
import 'statistic/statistic.dart';

class PlayerResponse {
  final Player? player;
  final List<Statistic>? statistics;

  PlayerResponse({
    this.player,
    this.statistics,
  });

  factory PlayerResponse.fromMap(Map<String, dynamic> map) => PlayerResponse(
        player: map['player'] != null ? Player.fromMap(map['player'] as Map<String, dynamic>) : null,
        statistics: map['statistics'] != null
            ? List<Statistic>.from(
                (map['statistics'] as List).map<Statistic?>(
                  (x) => Statistic.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'PlayerResponse(player: $player, statistics: $statistics)';

  @override
  bool operator ==(covariant PlayerResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return other.player == player && listEquals(other.statistics, statistics);
  }

  @override
  int get hashCode => player.hashCode ^ statistics.hashCode;
}
