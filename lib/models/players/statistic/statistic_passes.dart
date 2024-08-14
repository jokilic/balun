class StatisticPasses {
  final int? total;
  final int? key;
  final int? accuracy;

  StatisticPasses({
    this.total,
    this.key,
    this.accuracy,
  });

  factory StatisticPasses.fromMap(Map<String, dynamic> map) => StatisticPasses(
        total: map['total'] != null ? map['total'] as int : null,
        key: map['key'] != null ? map['key'] as int : null,
        accuracy: map['accuracy'] != null ? map['accuracy'] as int : null,
      );

  @override
  String toString() => 'StatisticPasses(total: $total, key: $key, accuracy: $accuracy)';

  @override
  bool operator ==(covariant StatisticPasses other) {
    if (identical(this, other)) {
      return true;
    }

    return other.total == total && other.key == key && other.accuracy == accuracy;
  }

  @override
  int get hashCode => total.hashCode ^ key.hashCode ^ accuracy.hashCode;
}
