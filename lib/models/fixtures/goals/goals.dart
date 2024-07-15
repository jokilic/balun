class Goals {
  final int? home;
  final int? away;

  Goals({
    this.home,
    this.away,
  });

  factory Goals.fromMap(Map<String, dynamic> map) => Goals(
        home: map['home'] != null ? map['home'] as int : null,
        away: map['away'] != null ? map['away'] as int : null,
      );

  @override
  String toString() => 'Goals(home: $home, away: $away)';

  @override
  bool operator ==(covariant Goals other) {
    if (identical(this, other)) {
      return true;
    }

    return other.home == home && other.away == away;
  }

  @override
  int get hashCode => home.hashCode ^ away.hashCode;
}
