class StatisticDuels {
  final int? total;
  final int? won;

  StatisticDuels({
    this.total,
    this.won,
  });

  factory StatisticDuels.fromMap(Map<String, dynamic> map) => StatisticDuels(
        total: map['total'] != null ? map['total'] as int : null,
        won: map['won'] != null ? map['won'] as int : null,
      );

  @override
  String toString() => 'StatisticDuels(total: $total, won: $won)';

  @override
  bool operator ==(covariant StatisticDuels other) {
    if (identical(this, other)) {
      return true;
    }

    return other.total == total && other.won == won;
  }

  @override
  int get hashCode => total.hashCode ^ won.hashCode;
}
