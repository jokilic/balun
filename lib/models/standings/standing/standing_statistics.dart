import 'standing_statistics_goals.dart';

class StandingStatistics {
  final int? played;
  final int? win;
  final int? draw;
  final int? lose;
  final StandingStatisticsGoals? goals;

  StandingStatistics({
    this.played,
    this.win,
    this.draw,
    this.lose,
    this.goals,
  });

  factory StandingStatistics.fromMap(Map<String, dynamic> map) => StandingStatistics(
        played: map['played'] != null ? map['played'] as int : null,
        win: map['win'] != null ? map['win'] as int : null,
        draw: map['draw'] != null ? map['draw'] as int : null,
        lose: map['lose'] != null ? map['lose'] as int : null,
        goals: map['goals'] != null ? StandingStatisticsGoals.fromMap(map['goals'] as Map<String, dynamic>) : null,
      );

  @override
  String toString() => 'StandingStatistics(played: $played, win: $win, draw: $draw, lose: $lose, goals: $goals)';

  @override
  bool operator ==(covariant StandingStatistics other) {
    if (identical(this, other)) {
      return true;
    }

    return other.played == played && other.win == win && other.draw == draw && other.lose == lose && other.goals == goals;
  }

  @override
  int get hashCode => played.hashCode ^ win.hashCode ^ draw.hashCode ^ lose.hashCode ^ goals.hashCode;
}
