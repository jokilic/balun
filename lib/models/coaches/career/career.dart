import '../team/team.dart';

class Career {
  final Team? team;
  final DateTime? start;
  final DateTime? end;

  Career({
    this.team,
    this.start,
    this.end,
  });

  factory Career.fromMap(Map<String, dynamic> map) => Career(
        team: map['team'] != null ? Team.fromMap(map['team'] as Map<String, dynamic>) : null,
        start: map['start'] != null ? DateTime.tryParse(map['start'] as String) : null,
        end: map['end'] != null ? DateTime.tryParse(map['end'] as String) : null,
      );

  @override
  String toString() => 'Career(team: $team, start: $start, end: $end)';

  @override
  bool operator ==(covariant Career other) {
    if (identical(this, other)) {
      return true;
    }

    return other.team == team && other.start == start && other.end == end;
  }

  @override
  int get hashCode => team.hashCode ^ start.hashCode ^ end.hashCode;
}
