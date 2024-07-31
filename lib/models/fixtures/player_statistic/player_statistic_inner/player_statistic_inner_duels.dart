class PlayerStatisticInnerDuels {
  final int? total;
  final int? won;

  PlayerStatisticInnerDuels({
    this.total,
    this.won,
  });

  factory PlayerStatisticInnerDuels.fromMap(Map<String, dynamic> map) => PlayerStatisticInnerDuels(
        total: map['total'] != null ? map['total'] as int : null,
        won: map['won'] != null ? map['won'] as int : null,
      );

  @override
  String toString() => 'PlayerStatisticInnerDuels(total: $total, won: $won)';

  @override
  bool operator ==(covariant PlayerStatisticInnerDuels other) {
    if (identical(this, other)) {
      return true;
    }

    return other.total == total && other.won == won;
  }

  @override
  int get hashCode => total.hashCode ^ won.hashCode;
}
