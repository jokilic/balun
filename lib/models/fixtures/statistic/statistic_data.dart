class StatisticData {
  final String? type;
  final dynamic value;
  final double valueDouble;

  StatisticData({
    required this.valueDouble,
    this.type,
    this.value,
  });

  factory StatisticData.fromMap(Map<String, dynamic> map) => StatisticData(
        type: map['type'] != null ? map['type'] as String : null,
        value: map['value'],
        valueDouble: map['value'] != null ? double.tryParse('${map['value']}'.replaceAll('%', '')) ?? 0.0 : 0.0,
      );

  @override
  String toString() => 'StatisticData(type: $type, value: $value)';

  @override
  bool operator ==(covariant StatisticData other) {
    if (identical(this, other)) {
      return true;
    }

    return other.type == type && other.value == value;
  }

  @override
  int get hashCode => type.hashCode ^ value.hashCode;
}
