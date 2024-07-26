import 'package:flutter/foundation.dart';

import '../paging_response.dart';
import 'team_response.dart';

class TeamsResponse {
  final dynamic errors;
  final int? results;
  final PagingResponse? paging;
  final List<TeamResponse>? response;

  TeamsResponse({
    this.errors,
    this.results,
    this.paging,
    this.response,
  });

  factory TeamsResponse.fromMap(Map<String, dynamic> map) => TeamsResponse(
        errors: map['errors'],
        results: map['results'] != null ? map['results'] as int : null,
        paging: map['paging'] != null ? PagingResponse.fromMap(map['paging'] as Map<String, dynamic>) : null,
        response: map['response'] != null
            ? List<TeamResponse>.from(
                (map['response'] as List).map<TeamResponse?>(
                  (x) => TeamResponse.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'TeamsResponse(errors: $errors, results: $results, paging: $paging, response: $response)';

  @override
  bool operator ==(covariant TeamsResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return mapEquals(other.errors, errors) && other.results == results && other.paging == paging && listEquals(other.response, response);
  }

  @override
  int get hashCode => errors.hashCode ^ results.hashCode ^ paging.hashCode ^ response.hashCode;
}
