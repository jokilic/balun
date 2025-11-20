import 'package:flutter/foundation.dart';

import '../paging_response.dart';
import 'status_inner_response.dart';

class StatusResponse {
  final dynamic errors;
  final int? results;
  final PagingResponse? paging;
  final StatusInnerResponse? response;

  StatusResponse({
    this.errors,
    this.results,
    this.paging,
    this.response,
  });

  factory StatusResponse.fromMap(Map<String, dynamic> map) => StatusResponse(
    errors: map['errors'],
    results: map['results'] != null ? map['results'] as int : null,
    paging: map['paging'] != null ? PagingResponse.fromMap(map['paging'] as Map<String, dynamic>) : null,
    response: map['response'] != null ? StatusInnerResponse.fromMap(map['response'] as Map<String, dynamic>) : null,
  );

  @override
  String toString() => 'StatusResponse(errors: $errors, results: $results, paging: $paging, response: $response)';

  @override
  bool operator ==(covariant StatusResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return mapEquals(other.errors, errors) && other.results == results && other.paging == paging && other.response == response;
  }

  @override
  int get hashCode => errors.hashCode ^ results.hashCode ^ paging.hashCode ^ response.hashCode;
}
