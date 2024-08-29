import 'package:flutter/foundation.dart';

import '../../paging_response.dart';
import 'search_countries_inner_response.dart';

class SearchCountriesResponse {
  final dynamic errors;
  final int? results;
  final PagingResponse? paging;
  final List<SearchCountriesInnerResponse>? response;

  SearchCountriesResponse({
    this.errors,
    this.results,
    this.paging,
    this.response,
  });

  factory SearchCountriesResponse.fromMap(Map<String, dynamic> map) => SearchCountriesResponse(
        errors: map['errors'],
        results: map['results'] != null ? map['results'] as int : null,
        paging: map['paging'] != null ? PagingResponse.fromMap(map['paging'] as Map<String, dynamic>) : null,
        response: map['response'] != null
            ? List<SearchCountriesInnerResponse>.from(
                (map['response'] as List).map<SearchCountriesInnerResponse?>(
                  (x) => SearchCountriesInnerResponse.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'SearchCountriesResponse(errors: $errors, results: $results, paging: $paging, response: $response)';

  @override
  bool operator ==(covariant SearchCountriesResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return mapEquals(other.errors, errors) && other.results == results && other.paging == paging && listEquals(other.response, response);
  }

  @override
  int get hashCode => errors.hashCode ^ results.hashCode ^ paging.hashCode ^ response.hashCode;
}
