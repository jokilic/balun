import 'package:flutter/foundation.dart';

import 'news_result.dart';

enum NewsStatus {
  success,
}

class NewsResponse {
  final NewsStatus? status;
  final int? totalResults;
  final List<NewsResult>? results;

  NewsResponse({
    this.status,
    this.totalResults,
    this.results,
  });

  factory NewsResponse.fromMap(Map<String, dynamic> map) => NewsResponse(
        status: map['status'] != null ? NewsStatus.values.byName(map['status'] as String) : null,
        totalResults: map['totalResults'] != null ? map['totalResults'] as int : null,
        results: map['results'] != null
            ? List<NewsResult>.from(
                (map['results'] as List).map<NewsResult?>(
                  (x) => NewsResult.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'NewsResponse(status: $status, totalResults: $totalResults, results: $results)';

  @override
  bool operator ==(covariant NewsResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return other.status == status && other.totalResults == totalResults && listEquals(other.results, results);
  }

  @override
  int get hashCode => status.hashCode ^ totalResults.hashCode ^ results.hashCode;
}
