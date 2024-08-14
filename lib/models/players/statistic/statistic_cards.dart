class StatisticCards {
  final int? yellow;
  final int? yellowRed;
  final int? red;

  StatisticCards({
    this.yellow,
    this.yellowRed,
    this.red,
  });

  factory StatisticCards.fromMap(Map<String, dynamic> map) => StatisticCards(
        yellow: map['yellow'] != null ? map['yellow'] as int : null,
        yellowRed: map['yellowred'] != null ? map['yellowred'] as int : null,
        red: map['red'] != null ? map['red'] as int : null,
      );

  @override
  String toString() => 'StatisticCards(yellow: $yellow, yellowRed: $yellowRed, red: $red)';

  @override
  bool operator ==(covariant StatisticCards other) {
    if (identical(this, other)) {
      return true;
    }

    return other.yellow == yellow && other.yellowRed == yellowRed && other.red == red;
  }

  @override
  int get hashCode => yellow.hashCode ^ yellowRed.hashCode ^ red.hashCode;
}
