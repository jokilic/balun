import 'package:flutter/foundation.dart';

import 'youtube_item.dart';

class YouTubeSearchResponse {
  final List<YouTubeItem> items;

  YouTubeSearchResponse({
    required this.items,
  });

  factory YouTubeSearchResponse.fromMap(Map<String, dynamic> map) => YouTubeSearchResponse(
        items: List<YouTubeItem>.from(
          (map['items'] as List).map<YouTubeItem>(
            (x) => YouTubeItem.fromMap(x as Map<String, dynamic>),
          ),
        ),
      );

  @override
  String toString() => 'YouTubeSearchResponse(items: $items)';

  @override
  bool operator ==(covariant YouTubeSearchResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return listEquals(other.items, items);
  }

  @override
  int get hashCode => items.hashCode;
}
