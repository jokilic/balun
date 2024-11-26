import 'youtube_item_id.dart';
import 'youtube_item_snippet.dart';

class YouTubeItem {
  final YouTubeItemId id;
  final YouTubeItemSnippet snippet;

  YouTubeItem({
    required this.id,
    required this.snippet,
  });

  factory YouTubeItem.fromMap(Map<String, dynamic> map) => YouTubeItem(
        id: YouTubeItemId.fromMap(map['id'] as Map<String, dynamic>),
        snippet: YouTubeItemSnippet.fromMap(map['snippet'] as Map<String, dynamic>),
      );

  @override
  String toString() => 'YouTubeItem(id: $id, snippet: $snippet)';

  @override
  bool operator ==(covariant YouTubeItem other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id && other.snippet == snippet;
  }

  @override
  int get hashCode => id.hashCode ^ snippet.hashCode;
}
