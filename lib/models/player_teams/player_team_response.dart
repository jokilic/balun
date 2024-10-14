import 'package:flutter/foundation.dart';

import 'team/team.dart';

class PlayerTeamResponse {
  final Team? team;
  final List<int>? seasons;

  PlayerTeamResponse({
    this.team,
    this.seasons,
  });

  factory PlayerTeamResponse.fromMap(Map<String, dynamic> map) => PlayerTeamResponse(
        team: map['team'] != null ? Team.fromMap(map['team'] as Map<String, dynamic>) : null,
        seasons: map['seasons'] != null ? List.from(map['seasons'] as List) : null,
      );

  @override
  String toString() => 'PlayerTeamResponse(team: $team, seasons: $seasons)';

  @override
  bool operator ==(covariant PlayerTeamResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return other.team == team && listEquals(other.seasons, seasons);
  }

  @override
  int get hashCode => team.hashCode ^ seasons.hashCode;
}
