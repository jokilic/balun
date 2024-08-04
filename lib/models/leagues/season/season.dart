import 'season_coverage.dart';

class Season {
  final int? year;
  final DateTime? start;
  final DateTime? end;
  final bool? current;
  final SeasonCoverage? coverage;

  Season({
    this.year,
    this.start,
    this.end,
    this.current,
    this.coverage,
  });

  factory Season.fromMap(Map<String, dynamic> map) => Season(
        year: map['year'] != null ? map['year'] as int : null,
        start: map['start'] != null ? DateTime.parse(map['start'] as String) : null,
        end: map['end'] != null ? DateTime.parse(map['end'] as String) : null,
        current: map['current'] != null ? map['current'] as bool : null,
        coverage: map['coverage'] != null ? SeasonCoverage.fromMap(map['coverage'] as Map<String, dynamic>) : null,
      );

  @override
  String toString() => 'Season(year: $year, start: $start, end: $end, current: $current, coverage: $coverage)';

  @override
  bool operator ==(covariant Season other) {
    if (identical(this, other)) {
      return true;
    }

    return other.year == year && other.start == start && other.end == end && other.current == current && other.coverage == coverage;
  }

  @override
  int get hashCode => year.hashCode ^ start.hashCode ^ end.hashCode ^ current.hashCode ^ coverage.hashCode;
}
