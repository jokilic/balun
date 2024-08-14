import 'package:flutter/foundation.dart';

import '../paging_response.dart';
import 'player_response.dart';

class PlayersResponse {
  final dynamic errors;
  final int? results;
  final PagingResponse? paging;
  final List<PlayerResponse>? response;

  PlayersResponse({
    this.errors,
    this.results,
    this.paging,
    this.response,
  });

  factory PlayersResponse.fromMap(Map<String, dynamic> map) => PlayersResponse(
        errors: map['errors'],
        results: map['results'] != null ? map['results'] as int : null,
        paging: map['paging'] != null ? PagingResponse.fromMap(map['paging'] as Map<String, dynamic>) : null,
        response: map['response'] != null
            ? List<PlayerResponse>.from(
                (map['response'] as List).map<PlayerResponse?>(
                  (x) => PlayerResponse.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'PlayersResponse(errors: $errors, results: $results, paging: $paging, response: $response)';

  @override
  bool operator ==(covariant PlayersResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return mapEquals(other.errors, errors) && other.results == results && other.paging == paging && listEquals(other.response, response);
  }

  @override
  int get hashCode => errors.hashCode ^ results.hashCode ^ paging.hashCode ^ response.hashCode;
}
