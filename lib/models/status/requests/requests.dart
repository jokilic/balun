class Requests {
  final int? current;
  final int? limitDay;

  Requests({
    this.current,
    this.limitDay,
  });

  factory Requests.fromMap(Map<String, dynamic> map) => Requests(
    current: map['current'] != null ? map['current'] as int : null,
    limitDay: map['limit_day'] != null ? map['limit_day'] as int : null,
  );

  @override
  String toString() => 'Requests(current: $current, limitDay: $limitDay)';

  @override
  bool operator ==(covariant Requests other) {
    if (identical(this, other)) {
      return true;
    }

    return other.current == current && other.limitDay == limitDay;
  }

  @override
  int get hashCode => current.hashCode ^ limitDay.hashCode;
}
