class StatisticPenalty {
  final int? won;
  final int? commited;
  final int? scored;
  final int? missed;
  final int? saved;

  StatisticPenalty({
    this.won,
    this.commited,
    this.scored,
    this.missed,
    this.saved,
  });

  factory StatisticPenalty.fromMap(Map<String, dynamic> map) => StatisticPenalty(
        won: map['won'] != null ? map['won'] as int : null,
        commited: map['commited'] != null ? map['commited'] as int : null,
        scored: map['scored'] != null ? map['scored'] as int : null,
        missed: map['missed'] != null ? map['missed'] as int : null,
        saved: map['saved'] != null ? map['saved'] as int : null,
      );

  @override
  String toString() => 'StatisticPenalty(won: $won, commited: $commited, scored: $scored, missed: $missed, saved: $saved)';

  @override
  bool operator ==(covariant StatisticPenalty other) {
    if (identical(this, other)) {
      return true;
    }

    return other.won == won && other.commited == commited && other.scored == scored && other.missed == missed && other.saved == saved;
  }

  @override
  int get hashCode => won.hashCode ^ commited.hashCode ^ scored.hashCode ^ missed.hashCode ^ saved.hashCode;
}
