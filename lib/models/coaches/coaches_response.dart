import 'package:flutter/foundation.dart';

import '../paging_response.dart';
import 'coach_response.dart';

class CoachesResponse {
  final dynamic errors;
  final int? results;
  final PagingResponse? paging;
  final List<CoachResponse>? response;

  CoachesResponse({
    this.errors,
    this.results,
    this.paging,
    this.response,
  });

  factory CoachesResponse.fromMap(Map<String, dynamic> map) => CoachesResponse(
        errors: map['errors'],
        results: map['results'] != null ? map['results'] as int : null,
        paging: map['paging'] != null ? PagingResponse.fromMap(map['paging'] as Map<String, dynamic>) : null,
        response: map['response'] != null
            ? List<CoachResponse>.from(
                (map['response'] as List).map<CoachResponse?>(
                  (x) => CoachResponse.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'CoachesResponse(errors: $errors, results: $results, paging: $paging, response: $response)';

  @override
  bool operator ==(covariant CoachesResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return mapEquals(other.errors, errors) && other.results == results && other.paging == paging && listEquals(other.response, response);
  }

  @override
  int get hashCode => errors.hashCode ^ results.hashCode ^ paging.hashCode ^ response.hashCode;
}
