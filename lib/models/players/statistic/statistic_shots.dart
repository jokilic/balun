class StatisticShots {
  final int? shotsTotal;
  final int? shotsOn;

  StatisticShots({
    this.shotsTotal,
    this.shotsOn,
  });

  factory StatisticShots.fromMap(Map<String, dynamic> map) => StatisticShots(
        shotsTotal: map['total'] != null ? map['total'] as int : null,
        shotsOn: map['on'] != null ? map['on'] as int : null,
      );

  @override
  String toString() => 'StatisticShots(shotsTotal: $shotsTotal, shotsOn: $shotsOn)';

  @override
  bool operator ==(covariant StatisticShots other) {
    if (identical(this, other)) {
      return true;
    }

    return other.shotsTotal == shotsTotal && other.shotsOn == shotsOn;
  }

  @override
  int get hashCode => shotsTotal.hashCode ^ shotsOn.hashCode;
}
