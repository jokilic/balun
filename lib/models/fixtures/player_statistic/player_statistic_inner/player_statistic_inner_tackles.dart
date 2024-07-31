class PlayerStatisticInnerTackles {
  final int? total;
  final int? blocks;
  final int? interceptions;

  PlayerStatisticInnerTackles({
    this.total,
    this.blocks,
    this.interceptions,
  });

  factory PlayerStatisticInnerTackles.fromMap(Map<String, dynamic> map) => PlayerStatisticInnerTackles(
        total: map['total'] != null ? map['total'] as int : null,
        blocks: map['blocks'] != null ? map['blocks'] as int : null,
        interceptions: map['interceptions'] != null ? map['interceptions'] as int : null,
      );

  @override
  String toString() => 'PlayerStatisticInnerTackles(total: $total, blocks: $blocks, interceptions: $interceptions)';

  @override
  bool operator ==(covariant PlayerStatisticInnerTackles other) {
    if (identical(this, other)) {
      return true;
    }

    return other.total == total && other.blocks == blocks && other.interceptions == interceptions;
  }

  @override
  int get hashCode => total.hashCode ^ blocks.hashCode ^ interceptions.hashCode;
}
