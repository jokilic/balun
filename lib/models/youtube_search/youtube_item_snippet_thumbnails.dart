import 'youtube_thumbnail.dart';

class YouTubeItemSnippetThumbnails {
  final YouTubeThumbnail defaultThumbnail;
  final YouTubeThumbnail mediumThumbnail;
  final YouTubeThumbnail highThumbnail;

  YouTubeItemSnippetThumbnails({
    required this.defaultThumbnail,
    required this.mediumThumbnail,
    required this.highThumbnail,
  });

  factory YouTubeItemSnippetThumbnails.fromMap(Map<String, dynamic> map) => YouTubeItemSnippetThumbnails(
        defaultThumbnail: YouTubeThumbnail.fromMap(map['default'] as Map<String, dynamic>),
        mediumThumbnail: YouTubeThumbnail.fromMap(map['medium'] as Map<String, dynamic>),
        highThumbnail: YouTubeThumbnail.fromMap(map['high'] as Map<String, dynamic>),
      );

  @override
  String toString() => 'YouTubeItemSnippetThumbnails(defaultThumbnail: $defaultThumbnail, mediumThumbnail: $mediumThumbnail, highThumbnail: $highThumbnail)';

  @override
  bool operator ==(covariant YouTubeItemSnippetThumbnails other) {
    if (identical(this, other)) {
      return true;
    }

    return other.defaultThumbnail == defaultThumbnail && other.mediumThumbnail == mediumThumbnail && other.highThumbnail == highThumbnail;
  }

  @override
  int get hashCode => defaultThumbnail.hashCode ^ mediumThumbnail.hashCode ^ highThumbnail.hashCode;
}
