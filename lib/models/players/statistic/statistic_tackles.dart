class StatisticTackles {
  final int? total;
  final int? blocks;
  final int? interceptions;

  StatisticTackles({
    this.total,
    this.blocks,
    this.interceptions,
  });

  factory StatisticTackles.fromMap(Map<String, dynamic> map) => StatisticTackles(
        total: map['total'] != null ? map['total'] as int : null,
        blocks: map['blocks'] != null ? map['blocks'] as int : null,
        interceptions: map['interceptions'] != null ? map['interceptions'] as int : null,
      );

  @override
  String toString() => 'StatisticTackles(total: $total, blocks: $blocks, interceptions: $interceptions)';

  @override
  bool operator ==(covariant StatisticTackles other) {
    if (identical(this, other)) {
      return true;
    }

    return other.total == total && other.blocks == blocks && other.interceptions == interceptions;
  }

  @override
  int get hashCode => total.hashCode ^ blocks.hashCode ^ interceptions.hashCode;
}
