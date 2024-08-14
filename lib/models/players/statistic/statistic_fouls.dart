class StatisticFouls {
  final int? drawn;
  final int? commited;

  StatisticFouls({
    this.drawn,
    this.commited,
  });

  factory StatisticFouls.fromMap(Map<String, dynamic> map) => StatisticFouls(
        drawn: map['drawn'] != null ? map['drawn'] as int : null,
        commited: map['commited'] != null ? map['commited'] as int : null,
      );

  @override
  String toString() => 'StatisticFouls(drawn: $drawn, commited: $commited)';

  @override
  bool operator ==(covariant StatisticFouls other) {
    if (identical(this, other)) {
      return true;
    }

    return other.drawn == drawn && other.commited == commited;
  }

  @override
  int get hashCode => drawn.hashCode ^ commited.hashCode;
}
