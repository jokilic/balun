import 'team/team.dart';
import 'venue/venue.dart';

class TeamResponse {
  final Team? team;
  final Venue? venue;

  TeamResponse({
    this.team,
    this.venue,
  });

  factory TeamResponse.fromMap(Map<String, dynamic> map) => TeamResponse(
        team: map['team'] != null ? Team.fromMap(map['team'] as Map<String, dynamic>) : null,
        venue: map['venue'] != null ? Venue.fromMap(map['venue'] as Map<String, dynamic>) : null,
      );

  @override
  String toString() => 'TeamResponse(team: $team, venue: $venue)';

  @override
  bool operator ==(covariant TeamResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return other.team == team && other.venue == venue;
  }

  @override
  int get hashCode => team.hashCode ^ venue.hashCode;
}
