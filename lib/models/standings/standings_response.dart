import 'package:flutter/foundation.dart';

import '../error_response.dart';
import '../paging_response.dart';
import 'standing_response.dart';

class StandingsResponse {
  final List<ErrorResponse>? errors;
  final int? results;
  final PagingResponse? paging;
  final List<StandingResponse>? response;

  StandingsResponse({
    this.errors,
    this.results,
    this.paging,
    this.response,
  });

  factory StandingsResponse.fromMap(Map<String, dynamic> map) => StandingsResponse(
        errors: map['errors'] != null
            ? List<ErrorResponse>.from(
                (map['errors'] as List).map<ErrorResponse?>(
                  (x) => ErrorResponse.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
        results: map['results'] != null ? map['results'] as int : null,
        paging: map['paging'] != null ? PagingResponse.fromMap(map['paging'] as Map<String, dynamic>) : null,
        response: map['response'] != null
            ? List<StandingResponse>.from(
                (map['response'] as List).map<StandingResponse?>(
                  (x) => StandingResponse.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'StandingsResponse(errors: $errors, results: $results, paging: $paging, response: $response)';

  @override
  bool operator ==(covariant StandingsResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return listEquals(other.errors, errors) && other.results == results && other.paging == paging && listEquals(other.response, response);
  }

  @override
  int get hashCode => errors.hashCode ^ results.hashCode ^ paging.hashCode ^ response.hashCode;
}
