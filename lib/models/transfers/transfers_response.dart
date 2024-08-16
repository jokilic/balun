import 'package:flutter/foundation.dart';

import '../paging_response.dart';
import 'transfer_response.dart';

class TransfersResponse {
  final dynamic errors;
  final int? results;
  final PagingResponse? paging;
  final List<TransferResponse>? response;

  TransfersResponse({
    this.errors,
    this.results,
    this.paging,
    this.response,
  });

  factory TransfersResponse.fromMap(Map<String, dynamic> map) => TransfersResponse(
        errors: map['errors'],
        results: map['results'] != null ? map['results'] as int : null,
        paging: map['paging'] != null ? PagingResponse.fromMap(map['paging'] as Map<String, dynamic>) : null,
        response: map['response'] != null
            ? List<TransferResponse>.from(
                (map['response'] as List).map<TransferResponse?>(
                  (x) => TransferResponse.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'TransfersResponse(errors: $errors, results: $results, paging: $paging, response: $response)';

  @override
  bool operator ==(covariant TransfersResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return mapEquals(other.errors, errors) && other.results == results && other.paging == paging && listEquals(other.response, response);
  }

  @override
  int get hashCode => errors.hashCode ^ results.hashCode ^ paging.hashCode ^ response.hashCode;
}
