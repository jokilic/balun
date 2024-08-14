class StatisticSubstitutes {
  final int? playerIn;
  final int? playerOut;
  final int? playerBench;

  StatisticSubstitutes({
    this.playerIn,
    this.playerOut,
    this.playerBench,
  });

  factory StatisticSubstitutes.fromMap(Map<String, dynamic> map) => StatisticSubstitutes(
        playerIn: map['in'] != null ? map['in'] as int : null,
        playerOut: map['out'] != null ? map['out'] as int : null,
        playerBench: map['bench'] != null ? map['bench'] as int : null,
      );

  @override
  String toString() => 'StatisticSubstitutes(playerIn: $playerIn, playerOut: $playerOut, playerBench: $playerBench)';

  @override
  bool operator ==(covariant StatisticSubstitutes other) {
    if (identical(this, other)) {
      return true;
    }

    return other.playerIn == playerIn && other.playerOut == playerOut && other.playerBench == playerBench;
  }

  @override
  int get hashCode => playerIn.hashCode ^ playerOut.hashCode ^ playerBench.hashCode;
}
