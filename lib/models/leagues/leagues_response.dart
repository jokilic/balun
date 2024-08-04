import 'package:flutter/foundation.dart';

import '../paging_response.dart';
import 'league_response.dart';

class LeaguesResponse {
  final dynamic errors;
  final int? results;
  final PagingResponse? paging;
  final List<LeagueResponse>? response;

  LeaguesResponse({
    this.errors,
    this.results,
    this.paging,
    this.response,
  });

  factory LeaguesResponse.fromMap(Map<String, dynamic> map) => LeaguesResponse(
        errors: map['errors'],
        results: map['results'] != null ? map['results'] as int : null,
        paging: map['paging'] != null ? PagingResponse.fromMap(map['paging'] as Map<String, dynamic>) : null,
        response: map['response'] != null
            ? List<LeagueResponse>.from(
                (map['response'] as List).map<LeagueResponse?>(
                  (x) => LeagueResponse.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'LeaguesResponse(errors: $errors, results: $results, paging: $paging, response: $response)';

  @override
  bool operator ==(covariant LeaguesResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return mapEquals(other.errors, errors) && other.results == results && other.paging == paging && listEquals(other.response, response);
  }

  @override
  int get hashCode => errors.hashCode ^ results.hashCode ^ paging.hashCode ^ response.hashCode;
}
