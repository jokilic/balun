import 'package:flutter/foundation.dart';

import '../../paging_response.dart';
import 'search_player_response.dart';

class SearchPlayersResponse {
  final dynamic errors;
  final int? results;
  final PagingResponse? paging;
  final List<SearchPlayerResponse>? response;

  SearchPlayersResponse({
    this.errors,
    this.results,
    this.paging,
    this.response,
  });

  factory SearchPlayersResponse.fromMap(Map<String, dynamic> map) => SearchPlayersResponse(
        errors: map['errors'],
        results: map['results'] != null ? map['results'] as int : null,
        paging: map['paging'] != null ? PagingResponse.fromMap(map['paging'] as Map<String, dynamic>) : null,
        response: map['response'] != null
            ? List<SearchPlayerResponse>.from(
                (map['response'] as List).map<SearchPlayerResponse?>(
                  (x) => SearchPlayerResponse.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'SearchLeaguesResponse(errors: $errors, results: $results, paging: $paging, response: $response)';

  @override
  bool operator ==(covariant SearchPlayersResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return mapEquals(other.errors, errors) && other.results == results && other.paging == paging && listEquals(other.response, response);
  }

  @override
  int get hashCode => errors.hashCode ^ results.hashCode ^ paging.hashCode ^ response.hashCode;
}
