class PlayerStatisticInnerGoals {
  final int? total;
  final int? conceded;
  final int? assists;
  final int? saves;

  PlayerStatisticInnerGoals({
    this.total,
    this.conceded,
    this.assists,
    this.saves,
  });

  factory PlayerStatisticInnerGoals.fromMap(Map<String, dynamic> map) => PlayerStatisticInnerGoals(
        total: map['total'] != null ? map['total'] as int : null,
        conceded: map['conceded'] != null ? map['conceded'] as int : null,
        assists: map['assists'] != null ? map['assists'] as int : null,
        saves: map['saves'] != null ? map['saves'] as int : null,
      );

  @override
  String toString() => 'PlayerStatisticInnerGoals(total: $total, conceded: $conceded, assists: $assists, saves: $saves)';

  @override
  bool operator ==(covariant PlayerStatisticInnerGoals other) {
    if (identical(this, other)) {
      return true;
    }

    return other.total == total && other.conceded == conceded && other.assists == assists && other.saves == saves;
  }

  @override
  int get hashCode => total.hashCode ^ conceded.hashCode ^ assists.hashCode ^ saves.hashCode;
}
