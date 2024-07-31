class PlayerStatisticInnerFouls {
  final int? drawn;
  final int? commited;

  PlayerStatisticInnerFouls({
    this.drawn,
    this.commited,
  });

  factory PlayerStatisticInnerFouls.fromMap(Map<String, dynamic> map) => PlayerStatisticInnerFouls(
        drawn: map['drawn'] != null ? map['drawn'] as int : null,
        commited: map['commited'] != null ? map['commited'] as int : null,
      );

  @override
  String toString() => 'PlayerStatisticInnerFouls(drawn: $drawn, commited: $commited)';

  @override
  bool operator ==(covariant PlayerStatisticInnerFouls other) {
    if (identical(this, other)) {
      return true;
    }

    return other.drawn == drawn && other.commited == commited;
  }

  @override
  int get hashCode => drawn.hashCode ^ commited.hashCode;
}
