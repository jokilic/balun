class PlayerStatisticInnerCards {
  final int? yellow;
  final int? red;

  PlayerStatisticInnerCards({
    this.yellow,
    this.red,
  });

  factory PlayerStatisticInnerCards.fromMap(Map<String, dynamic> map) => PlayerStatisticInnerCards(
        yellow: map['yellow'] != null ? map['yellow'] as int : null,
        red: map['red'] != null ? map['red'] as int : null,
      );

  @override
  String toString() => 'PlayerStatisticInnerCards(yellow: $yellow, red: $red)';

  @override
  bool operator ==(covariant PlayerStatisticInnerCards other) {
    if (identical(this, other)) {
      return true;
    }

    return other.yellow == yellow && other.red == red;
  }

  @override
  int get hashCode => yellow.hashCode ^ red.hashCode;
}
