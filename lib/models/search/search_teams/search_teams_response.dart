import 'package:flutter/foundation.dart';

import '../../paging_response.dart';
import 'search_team_response.dart';

class SearchTeamsResponse {
  final dynamic errors;
  final int? results;
  final PagingResponse? paging;
  final List<SearchTeamResponse>? response;

  SearchTeamsResponse({
    this.errors,
    this.results,
    this.paging,
    this.response,
  });

  factory SearchTeamsResponse.fromMap(Map<String, dynamic> map) => SearchTeamsResponse(
        errors: map['errors'],
        results: map['results'] != null ? map['results'] as int : null,
        paging: map['paging'] != null ? PagingResponse.fromMap(map['paging'] as Map<String, dynamic>) : null,
        response: map['response'] != null
            ? List<SearchTeamResponse>.from(
                (map['response'] as List).map<SearchTeamResponse?>(
                  (x) => SearchTeamResponse.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'SearchTeamsResponse(errors: $errors, results: $results, paging: $paging, response: $response)';

  @override
  bool operator ==(covariant SearchTeamsResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return mapEquals(other.errors, errors) && other.results == results && other.paging == paging && listEquals(other.response, response);
  }

  @override
  int get hashCode => errors.hashCode ^ results.hashCode ^ paging.hashCode ^ response.hashCode;
}
