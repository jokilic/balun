import 'package:flutter/foundation.dart';

import '../paging_response.dart';
import 'squad_response.dart';

class SquadsResponse {
  final dynamic errors;
  final int? results;
  final PagingResponse? paging;
  final List<SquadResponse>? response;

  SquadsResponse({
    this.errors,
    this.results,
    this.paging,
    this.response,
  });

  factory SquadsResponse.fromMap(Map<String, dynamic> map) => SquadsResponse(
        errors: map['errors'],
        results: map['results'] != null ? map['results'] as int : null,
        paging: map['paging'] != null ? PagingResponse.fromMap(map['paging'] as Map<String, dynamic>) : null,
        response: map['response'] != null
            ? List<SquadResponse>.from(
                (map['response'] as List).map<SquadResponse?>(
                  (x) => SquadResponse.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'SquadsResponse(errors: $errors, results: $results, paging: $paging, response: $response)';

  @override
  bool operator ==(covariant SquadsResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return mapEquals(other.errors, errors) && other.results == results && other.paging == paging && listEquals(other.response, response);
  }

  @override
  int get hashCode => errors.hashCode ^ results.hashCode ^ paging.hashCode ^ response.hashCode;
}
