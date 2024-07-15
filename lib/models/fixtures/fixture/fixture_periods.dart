import 'dart:convert';

class FixturePeriods {
  final DateTime? first;
  final DateTime? second;

  FixturePeriods({
    this.first,
    this.second,
  });

  factory FixturePeriods.fromMap(Map<String, dynamic> map) => FixturePeriods(
        first: map['first'] != null ? DateTime.fromMillisecondsSinceEpoch(map['first'] as int) : null,
        second: map['second'] != null ? DateTime.fromMillisecondsSinceEpoch(map['second'] as int) : null,
      );

  factory FixturePeriods.fromJson(String source) => FixturePeriods.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FixturePeriods(first: $first, second: $second)';

  @override
  bool operator ==(covariant FixturePeriods other) {
    if (identical(this, other)) {
      return true;
    }

    return other.first == first && other.second == second;
  }

  @override
  int get hashCode => first.hashCode ^ second.hashCode;
}
