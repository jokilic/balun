import 'package:flutter/foundation.dart';

import '../paging_response.dart';
import 'player_team_response.dart';

class PlayerTeamsResponse {
  final dynamic errors;
  final int? results;
  final PagingResponse? paging;
  final List<PlayerTeamResponse>? response;

  PlayerTeamsResponse({
    this.errors,
    this.results,
    this.paging,
    this.response,
  });

  factory PlayerTeamsResponse.fromMap(Map<String, dynamic> map) => PlayerTeamsResponse(
        errors: map['errors'],
        results: map['results'] != null ? map['results'] as int : null,
        paging: map['paging'] != null ? PagingResponse.fromMap(map['paging'] as Map<String, dynamic>) : null,
        response: map['response'] != null
            ? List<PlayerTeamResponse>.from(
                (map['response'] as List).map<PlayerTeamResponse?>(
                  (x) => PlayerTeamResponse.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'PlayerTeamsResponse(errors: $errors, results: $results, paging: $paging, response: $response)';

  @override
  bool operator ==(covariant PlayerTeamsResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return mapEquals(other.errors, errors) && other.results == results && other.paging == paging && listEquals(other.response, response);
  }

  @override
  int get hashCode => errors.hashCode ^ results.hashCode ^ paging.hashCode ^ response.hashCode;
}
