import 'event_assist.dart';
import 'event_player.dart';
import 'event_team.dart';
import 'event_time.dart';

class Event {
  final EventTime? time;
  final EventTeam? team;
  final EventPlayer? player;
  final EventAssist? assist;
  final String? type;
  final String? detail;
  final String? comments;

  Event({
    this.time,
    this.team,
    this.player,
    this.assist,
    this.type,
    this.detail,
    this.comments,
  });

  factory Event.fromMap(Map<String, dynamic> map) => Event(
        time: map['time'] != null ? EventTime.fromMap(map['time'] as Map<String, dynamic>) : null,
        team: map['team'] != null ? EventTeam.fromMap(map['team'] as Map<String, dynamic>) : null,
        player: map['player'] != null ? EventPlayer.fromMap(map['player'] as Map<String, dynamic>) : null,
        assist: map['assist'] != null ? EventAssist.fromMap(map['assist'] as Map<String, dynamic>) : null,
        type: map['type'] != null ? map['type'] as String : null,
        detail: map['detail'] != null ? map['detail'] as String : null,
        comments: map['comments'] != null ? map['comments'] as String : null,
      );

  @override
  String toString() => 'Event(time: $time, team: $team, player: $player, assist: $assist, type: $type, detail: $detail, comments: $comments)';

  @override
  bool operator ==(covariant Event other) {
    if (identical(this, other)) {
      return true;
    }

    return other.time == time &&
        other.team == team &&
        other.player == player &&
        other.assist == assist &&
        other.type == type &&
        other.detail == detail &&
        other.comments == comments;
  }

  @override
  int get hashCode => time.hashCode ^ team.hashCode ^ player.hashCode ^ assist.hashCode ^ type.hashCode ^ detail.hashCode ^ comments.hashCode;
}
