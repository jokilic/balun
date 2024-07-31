class PlayerStatisticInnerPasses {
  final int? total;
  final int? key;
  final int? accuracy;

  PlayerStatisticInnerPasses({
    this.total,
    this.key,
    this.accuracy,
  });

  factory PlayerStatisticInnerPasses.fromMap(Map<String, dynamic> map) => PlayerStatisticInnerPasses(
        total: map['total'] != null ? map['total'] as int : null,
        key: map['key'] != null ? map['key'] as int : null,
        accuracy: map['accuracy'] != null ? int.tryParse(map['accuracy'] as String) : null,
      );

  @override
  String toString() => 'PlayerStatisticInnerPasses(total: $total, key: $key, accuracy: $accuracy)';

  @override
  bool operator ==(covariant PlayerStatisticInnerPasses other) {
    if (identical(this, other)) {
      return true;
    }

    return other.total == total && other.key == key && other.accuracy == accuracy;
  }

  @override
  int get hashCode => total.hashCode ^ key.hashCode ^ accuracy.hashCode;
}
