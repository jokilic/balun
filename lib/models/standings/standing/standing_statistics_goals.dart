class StandingStatisticsGoals {
  final int? goalsFor;
  final int? goalsAgainst;

  StandingStatisticsGoals({
    this.goalsFor,
    this.goalsAgainst,
  });

  factory StandingStatisticsGoals.fromMap(Map<String, dynamic> map) => StandingStatisticsGoals(
        goalsFor: map['for'] != null ? map['for'] as int : null,
        goalsAgainst: map['against'] != null ? map['against'] as int : null,
      );

  @override
  String toString() => 'StandingStatisticsGoals(goalsFor: $goalsFor, goalsAgainst: $goalsAgainst)';

  @override
  bool operator ==(covariant StandingStatisticsGoals other) {
    if (identical(this, other)) {
      return true;
    }

    return other.goalsFor == goalsFor && other.goalsAgainst == goalsAgainst;
  }

  @override
  int get hashCode => goalsFor.hashCode ^ goalsAgainst.hashCode;
}
