class EventTime {
  final int? elapsed;
  final int? extra;

  EventTime({
    this.elapsed,
    this.extra,
  });

  factory EventTime.fromMap(Map<String, dynamic> map) => EventTime(
        elapsed: map['elapsed'] != null ? map['elapsed'] as int : null,
        extra: map['extra'] != null ? map['extra'] as int : null,
      );

  @override
  String toString() => 'EventTime(elapsed: $elapsed, extra: $extra)';

  @override
  bool operator ==(covariant EventTime other) {
    if (identical(this, other)) {
      return true;
    }

    return other.elapsed == elapsed && other.extra == extra;
  }

  @override
  int get hashCode => elapsed.hashCode ^ extra.hashCode;
}
