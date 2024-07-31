class PlayerStatisticInnerShots {
  final int? total;
  final int? on;

  PlayerStatisticInnerShots({
    this.total,
    this.on,
  });

  factory PlayerStatisticInnerShots.fromMap(Map<String, dynamic> map) => PlayerStatisticInnerShots(
        total: map['total'] != null ? map['total'] as int : null,
        on: map['on'] != null ? map['on'] as int : null,
      );

  @override
  String toString() => 'PlayerStatisticInnerShots(total: $total, on: $on)';

  @override
  bool operator ==(covariant PlayerStatisticInnerShots other) {
    if (identical(this, other)) {
      return true;
    }

    return other.total == total && other.on == on;
  }

  @override
  int get hashCode => total.hashCode ^ on.hashCode;
}
