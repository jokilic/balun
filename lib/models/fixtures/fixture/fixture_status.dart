class FixtureStatus {
  final String? long;
  final String? short;
  final int? elapsed;

  FixtureStatus({
    this.long,
    this.short,
    this.elapsed,
  });

  factory FixtureStatus.fromMap(Map<String, dynamic> map) => FixtureStatus(
        long: map['long'] != null ? map['long'] as String : null,
        short: map['short'] != null ? map['short'] as String : null,
        elapsed: map['elapsed'] != null ? map['elapsed'] as int : null,
      );

  @override
  String toString() => 'FixtureStatus(long: $long, short: $short, elapsed: $elapsed)';

  @override
  bool operator ==(covariant FixtureStatus other) {
    if (identical(this, other)) {
      return true;
    }

    return other.long == long && other.short == short && other.elapsed == elapsed;
  }

  @override
  int get hashCode => long.hashCode ^ short.hashCode ^ elapsed.hashCode;
}
