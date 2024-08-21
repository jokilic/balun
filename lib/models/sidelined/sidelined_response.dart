import 'package:flutter/foundation.dart';

import '../paging_response.dart';
import 'sidelined_inner_response.dart';

class SidelinedResponse {
  final dynamic errors;
  final int? results;
  final PagingResponse? paging;
  final List<SidelinedInnerResponse>? response;

  SidelinedResponse({
    this.errors,
    this.results,
    this.paging,
    this.response,
  });

  factory SidelinedResponse.fromMap(Map<String, dynamic> map) => SidelinedResponse(
        errors: map['errors'],
        results: map['results'] != null ? map['results'] as int : null,
        paging: map['paging'] != null ? PagingResponse.fromMap(map['paging'] as Map<String, dynamic>) : null,
        response: map['response'] != null
            ? List<SidelinedInnerResponse>.from(
                (map['response'] as List).map<SidelinedInnerResponse?>(
                  (x) => SidelinedInnerResponse.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'SidelinedResponse(errors: $errors, results: $results, paging: $paging, response: $response)';

  @override
  bool operator ==(covariant SidelinedResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return mapEquals(other.errors, errors) && other.results == results && other.paging == paging && listEquals(other.response, response);
  }

  @override
  int get hashCode => errors.hashCode ^ results.hashCode ^ paging.hashCode ^ response.hashCode;
}
