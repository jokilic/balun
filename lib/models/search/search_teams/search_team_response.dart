import 'team/team.dart';
import 'venue/venue.dart';

class SearchTeamResponse {
  final Team? team;
  final Venue? venue;

  SearchTeamResponse({
    this.team,
    this.venue,
  });

  factory SearchTeamResponse.fromMap(Map<String, dynamic> map) => SearchTeamResponse(
        team: map['team'] != null ? Team.fromMap(map['team'] as Map<String, dynamic>) : null,
        venue: map['venue'] != null ? Venue.fromMap(map['venue'] as Map<String, dynamic>) : null,
      );

  @override
  String toString() => 'SearchTeamResponse(team: $team, venue: $venue)';

  @override
  bool operator ==(covariant SearchTeamResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return other.team == team && other.venue == venue;
  }

  @override
  int get hashCode => team.hashCode ^ venue.hashCode;
}
