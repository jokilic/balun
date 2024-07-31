import 'package:flutter/foundation.dart';

import 'player_statistic_data.dart';
import 'player_statistic_team.dart';

class PlayerStatistic {
  final PlayerStatisticTeam? team;
  final List<PlayerStatisticData>? statistics;

  PlayerStatistic({
    this.team,
    this.statistics,
  });

  factory PlayerStatistic.fromMap(Map<String, dynamic> map) => PlayerStatistic(
        team: map['team'] != null ? PlayerStatisticTeam.fromMap(map['team'] as Map<String, dynamic>) : null,
        statistics: map['players'] != null
            ? List<PlayerStatisticData>.from(
                (map['players'] as List).map<PlayerStatisticData?>(
                  (x) => PlayerStatisticData.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'PlayerStatistic(team: $team, statistics: $statistics)';

  @override
  bool operator ==(covariant PlayerStatistic other) {
    if (identical(this, other)) {
      return true;
    }

    return other.team == team && listEquals(other.statistics, statistics);
  }

  @override
  int get hashCode => team.hashCode ^ statistics.hashCode;
}
