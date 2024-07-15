import 'team.dart';

class Teams {
  final Team? home;
  final Team? away;

  Teams({
    this.home,
    this.away,
  });

  factory Teams.fromMap(Map<String, dynamic> map) => Teams(
        home: map['home'] != null ? Team.fromMap(map['home'] as Map<String, dynamic>) : null,
        away: map['away'] != null ? Team.fromMap(map['away'] as Map<String, dynamic>) : null,
      );

  @override
  String toString() => 'Teams(home: $home, away: $away)';

  @override
  bool operator ==(covariant Teams other) {
    if (identical(this, other)) {
      return true;
    }

    return other.home == home && other.away == away;
  }

  @override
  int get hashCode => home.hashCode ^ away.hashCode;
}
