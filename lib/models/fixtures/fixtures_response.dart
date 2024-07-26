import 'package:flutter/foundation.dart';

import '../paging_response.dart';
import 'fixture_response.dart';

class FixturesResponse {
  final dynamic errors;
  final int? results;
  final PagingResponse? paging;
  final List<FixtureResponse>? response;

  FixturesResponse({
    this.errors,
    this.results,
    this.paging,
    this.response,
  });

  factory FixturesResponse.fromMap(Map<String, dynamic> map) => FixturesResponse(
        errors: map['errors'],
        results: map['results'] != null ? map['results'] as int : null,
        paging: map['paging'] != null ? PagingResponse.fromMap(map['paging'] as Map<String, dynamic>) : null,
        response: map['response'] != null
            ? List<FixtureResponse>.from(
                (map['response'] as List).map<FixtureResponse?>(
                  (x) => FixtureResponse.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'FixturesResponse(errors: $errors, results: $results, paging: $paging, response: $response)';

  @override
  bool operator ==(covariant FixturesResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return mapEquals(other.errors, errors) && other.results == results && other.paging == paging && listEquals(other.response, response);
  }

  @override
  int get hashCode => errors.hashCode ^ results.hashCode ^ paging.hashCode ^ response.hashCode;
}
