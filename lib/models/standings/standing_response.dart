import 'league/league.dart';

class StandingResponse {
  final League? league;

  StandingResponse({
    this.league,
  });

  factory StandingResponse.fromMap(Map<String, dynamic> map) => StandingResponse(
        league: map['league'] != null ? League.fromMap(map['league'] as Map<String, dynamic>) : null,
      );

  @override
  String toString() => 'StandingResponse(league: $league)';

  @override
  bool operator ==(covariant StandingResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return other.league == league;
  }

  @override
  int get hashCode => league.hashCode;
}
