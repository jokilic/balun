import 'package:flutter/foundation.dart';

import '../../paging_response.dart';
import 'search_league_response.dart';

class SearchLeaguesResponse {
  final dynamic errors;
  final int? results;
  final PagingResponse? paging;
  final List<SearchLeagueResponse>? response;

  SearchLeaguesResponse({
    this.errors,
    this.results,
    this.paging,
    this.response,
  });

  factory SearchLeaguesResponse.fromMap(Map<String, dynamic> map) => SearchLeaguesResponse(
        errors: map['errors'],
        results: map['results'] != null ? map['results'] as int : null,
        paging: map['paging'] != null ? PagingResponse.fromMap(map['paging'] as Map<String, dynamic>) : null,
        response: map['response'] != null
            ? List<SearchLeagueResponse>.from(
                (map['response'] as List).map<SearchLeagueResponse?>(
                  (x) => SearchLeagueResponse.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'SearchLeaguesResponse(errors: $errors, results: $results, paging: $paging, response: $response)';

  @override
  bool operator ==(covariant SearchLeaguesResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return mapEquals(other.errors, errors) && other.results == results && other.paging == paging && listEquals(other.response, response);
  }

  @override
  int get hashCode => errors.hashCode ^ results.hashCode ^ paging.hashCode ^ response.hashCode;
}
