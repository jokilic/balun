import 'package:flutter/foundation.dart';

import 'statistic_data.dart';
import 'statistic_team.dart';

class Statistic {
  final StatisticTeam? team;
  final List<StatisticData>? statistics;

  Statistic({
    this.team,
    this.statistics,
  });

  factory Statistic.fromMap(Map<String, dynamic> map) => Statistic(
        team: map['team'] != null ? StatisticTeam.fromMap(map['team'] as Map<String, dynamic>) : null,
        statistics: map['statistics'] != null
            ? List<StatisticData>.from(
                (map['statistics'] as List).map<StatisticData?>(
                  (x) => StatisticData.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'Statistic(team: $team, statistics: $statistics)';

  @override
  bool operator ==(covariant Statistic other) {
    if (identical(this, other)) {
      return true;
    }

    return other.team == team && listEquals(other.statistics, statistics);
  }

  @override
  int get hashCode => team.hashCode ^ statistics.hashCode;
}
