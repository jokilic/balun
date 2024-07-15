import 'score_section.dart';

class Score {
  final ScoreSection? halftime;
  final ScoreSection? fulltime;
  final ScoreSection? extratime;
  final ScoreSection? penalty;

  Score({
    this.halftime,
    this.fulltime,
    this.extratime,
    this.penalty,
  });

  factory Score.fromMap(Map<String, dynamic> map) => Score(
        halftime: map['halftime'] != null ? ScoreSection.fromMap(map['halftime'] as Map<String, dynamic>) : null,
        fulltime: map['fulltime'] != null ? ScoreSection.fromMap(map['fulltime'] as Map<String, dynamic>) : null,
        extratime: map['extratime'] != null ? ScoreSection.fromMap(map['extratime'] as Map<String, dynamic>) : null,
        penalty: map['penalty'] != null ? ScoreSection.fromMap(map['penalty'] as Map<String, dynamic>) : null,
      );

  @override
  String toString() => 'Score(halftime: $halftime, fulltime: $fulltime, extratime: $extratime, penalty: $penalty)';

  @override
  bool operator ==(covariant Score other) {
    if (identical(this, other)) {
      return true;
    }

    return other.halftime == halftime && other.fulltime == fulltime && other.extratime == extratime && other.penalty == penalty;
  }

  @override
  int get hashCode => halftime.hashCode ^ fulltime.hashCode ^ extratime.hashCode ^ penalty.hashCode;
}
