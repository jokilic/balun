import 'youtube_item_snippet_thumbnails.dart';

class YouTubeItemSnippet {
  final DateTime publishedAt;
  final String channelId;
  final String title;
  final String description;
  final YouTubeItemSnippetThumbnails thumbnails;
  final String channelTitle;
  final String liveBroadcastContent;
  final DateTime publishTime;

  YouTubeItemSnippet({
    required this.publishedAt,
    required this.channelId,
    required this.title,
    required this.description,
    required this.thumbnails,
    required this.channelTitle,
    required this.liveBroadcastContent,
    required this.publishTime,
  });

  factory YouTubeItemSnippet.fromMap(Map<String, dynamic> map) => YouTubeItemSnippet(
        publishedAt: DateTime.parse(map['publishedAt'] as String),
        channelId: map['channelId'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        thumbnails: YouTubeItemSnippetThumbnails.fromMap(map['thumbnails'] as Map<String, dynamic>),
        channelTitle: map['channelTitle'] as String,
        liveBroadcastContent: map['liveBroadcastContent'] as String,
        publishTime: DateTime.parse(map['publishTime'] as String),
      );

  @override
  String toString() =>
      'YouTubeItemSnippet(publishedAt: $publishedAt, channelId: $channelId, title: $title, description: $description, thumbnails: $thumbnails, channelTitle: $channelTitle, liveBroadcastContent: $liveBroadcastContent, publishTime: $publishTime)';

  @override
  bool operator ==(covariant YouTubeItemSnippet other) {
    if (identical(this, other)) {
      return true;
    }

    return other.publishedAt == publishedAt &&
        other.channelId == channelId &&
        other.title == title &&
        other.description == description &&
        other.thumbnails == thumbnails &&
        other.channelTitle == channelTitle &&
        other.liveBroadcastContent == liveBroadcastContent &&
        other.publishTime == publishTime;
  }

  @override
  int get hashCode =>
      publishedAt.hashCode ^
      channelId.hashCode ^
      title.hashCode ^
      description.hashCode ^
      thumbnails.hashCode ^
      channelTitle.hashCode ^
      liveBroadcastContent.hashCode ^
      publishTime.hashCode;
}
