import 'package:flutter/foundation.dart';

import 'player_statistic_inner/player_statistic_inner.dart';
import 'player_statistic_player.dart';

class PlayerStatisticData {
  final PlayerStatisticPlayer? player;
  final List<PlayerStatisticInner>? statistic;

  PlayerStatisticData({
    this.player,
    this.statistic,
  });

  factory PlayerStatisticData.fromMap(Map<String, dynamic> map) => PlayerStatisticData(
        player: map['player'] != null ? PlayerStatisticPlayer.fromMap(map['player'] as Map<String, dynamic>) : null,
        statistic: map['statistics'] != null
            ? List<PlayerStatisticInner>.from(
                (map['statistics'] as List).map<PlayerStatisticInner?>(
                  (x) => PlayerStatisticInner.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'PlayerStatisticData(player: $player, statistic: $statistic)';

  @override
  bool operator ==(covariant PlayerStatisticData other) {
    if (identical(this, other)) {
      return true;
    }

    return other.player == player && listEquals(other.statistic, statistic);
  }

  @override
  int get hashCode => player.hashCode ^ statistic.hashCode;
}
