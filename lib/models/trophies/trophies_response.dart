import 'package:flutter/foundation.dart';

import '../paging_response.dart';
import 'trophy_response.dart';

class TrophiesResponse {
  final dynamic errors;
  final int? results;
  final PagingResponse? paging;
  final List<TrophyResponse>? response;

  TrophiesResponse({
    this.errors,
    this.results,
    this.paging,
    this.response,
  });

  factory TrophiesResponse.fromMap(Map<String, dynamic> map) => TrophiesResponse(
        errors: map['errors'],
        results: map['results'] != null ? map['results'] as int : null,
        paging: map['paging'] != null ? PagingResponse.fromMap(map['paging'] as Map<String, dynamic>) : null,
        response: map['response'] != null
            ? List<TrophyResponse>.from(
                (map['response'] as List).map<TrophyResponse?>(
                  (x) => TrophyResponse.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'TrophiesResponse(errors: $errors, results: $results, paging: $paging, response: $response)';

  @override
  bool operator ==(covariant TrophiesResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return mapEquals(other.errors, errors) && other.results == results && other.paging == paging && listEquals(other.response, response);
  }

  @override
  int get hashCode => errors.hashCode ^ results.hashCode ^ paging.hashCode ^ response.hashCode;
}
