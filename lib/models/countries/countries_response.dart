import 'package:flutter/foundation.dart';

import '../paging_response.dart';
import 'country_response.dart';

class CountriesResponse {
  final dynamic errors;
  final int? results;
  final PagingResponse? paging;
  final List<CountryResponse>? response;

  CountriesResponse({
    this.errors,
    this.results,
    this.paging,
    this.response,
  });

  factory CountriesResponse.fromMap(Map<String, dynamic> map) => CountriesResponse(
        errors: map['errors'],
        results: map['results'] != null ? map['results'] as int : null,
        paging: map['paging'] != null ? PagingResponse.fromMap(map['paging'] as Map<String, dynamic>) : null,
        response: map['response'] != null
            ? List<CountryResponse>.from(
                (map['response'] as List).map<CountryResponse?>(
                  (x) => CountryResponse.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'CountriesResponse(errors: $errors, results: $results, paging: $paging, response: $response)';

  @override
  bool operator ==(covariant CountriesResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return mapEquals(other.errors, errors) && other.results == results && other.paging == paging && listEquals(other.response, response);
  }

  @override
  int get hashCode => errors.hashCode ^ results.hashCode ^ paging.hashCode ^ response.hashCode;
}
