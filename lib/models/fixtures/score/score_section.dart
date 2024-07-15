class ScoreSection {
  final int? home;
  final int? away;

  ScoreSection({
    this.home,
    this.away,
  });

  factory ScoreSection.fromMap(Map<String, dynamic> map) => ScoreSection(
        home: map['home'] != null ? map['home'] as int : null,
        away: map['away'] != null ? map['away'] as int : null,
      );

  @override
  String toString() => 'ScoreSection(home: $home, away: $away)';

  @override
  bool operator ==(covariant ScoreSection other) {
    if (identical(this, other)) {
      return true;
    }

    return other.home == home && other.away == away;
  }

  @override
  int get hashCode => home.hashCode ^ away.hashCode;
}
