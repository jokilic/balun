import 'package:flutter/foundation.dart';

import '../team/team.dart';
import 'standing_statistics.dart';

class Standing {
  final List<StandingSingle>? standing;

  Standing({
    this.standing,
  });

  factory Standing.fromMap(Map<String, dynamic> map) => Standing(
        standing: map['standing'] != null
            ? List<StandingSingle>.from(
                (map['standing'] as List).map<StandingSingle?>(
                  (x) => StandingSingle.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'Standing(standing: $standing)';

  @override
  bool operator ==(covariant Standing other) {
    if (identical(this, other)) {
      return true;
    }

    return listEquals(other.standing, standing);
  }

  @override
  int get hashCode => standing.hashCode;
}

class StandingSingle {
  final int? position;
  final Team? team;
  final int? points;
  final int? goalsDiff;
  final String? group;
  final String? form;
  final String? status;
  final String? description;
  final StandingStatistics? all;
  final StandingStatistics? home;
  final StandingStatistics? away;
  final DateTime? update;

  StandingSingle({
    this.position,
    this.team,
    this.points,
    this.goalsDiff,
    this.group,
    this.form,
    this.status,
    this.description,
    this.all,
    this.home,
    this.away,
    this.update,
  });

  factory StandingSingle.fromMap(Map<String, dynamic> map) => StandingSingle(
        position: map['position'] != null ? map['position'] as int : null,
        team: map['team'] != null ? Team.fromMap(map['team'] as Map<String, dynamic>) : null,
        points: map['points'] != null ? map['points'] as int : null,
        goalsDiff: map['goalsDiff'] != null ? map['goalsDiff'] as int : null,
        group: map['group'] != null ? map['group'] as String : null,
        form: map['form'] != null ? map['form'] as String : null,
        status: map['status'] != null ? map['status'] as String : null,
        description: map['description'] != null ? map['description'] as String : null,
        all: map['all'] != null ? StandingStatistics.fromMap(map['all'] as Map<String, dynamic>) : null,
        home: map['home'] != null ? StandingStatistics.fromMap(map['home'] as Map<String, dynamic>) : null,
        away: map['away'] != null ? StandingStatistics.fromMap(map['away'] as Map<String, dynamic>) : null,
        update: map['update'] != null ? DateTime.fromMillisecondsSinceEpoch(map['update'] as int) : null,
      );

  @override
  String toString() =>
      'StandingSingle(position: $position, team: $team, points: $points, goalsDiff: $goalsDiff, group: $group, form: $form, status: $status, description: $description, all: $all, home: $home, away: $away, update: $update)';

  @override
  bool operator ==(covariant StandingSingle other) {
    if (identical(this, other)) {
      return true;
    }

    return other.position == position &&
        other.team == team &&
        other.points == points &&
        other.goalsDiff == goalsDiff &&
        other.group == group &&
        other.form == form &&
        other.status == status &&
        other.description == description &&
        other.all == all &&
        other.home == home &&
        other.away == away &&
        other.update == update;
  }

  @override
  int get hashCode =>
      position.hashCode ^
      team.hashCode ^
      points.hashCode ^
      goalsDiff.hashCode ^
      group.hashCode ^
      form.hashCode ^
      status.hashCode ^
      description.hashCode ^
      all.hashCode ^
      home.hashCode ^
      away.hashCode ^
      update.hashCode;
}
