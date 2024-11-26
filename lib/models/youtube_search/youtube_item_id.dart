class YouTubeItemId {
  final String videoId;

  YouTubeItemId({
    required this.videoId,
  });

  factory YouTubeItemId.fromMap(Map<String, dynamic> map) => YouTubeItemId(
        videoId: map['videoId'] as String,
      );

  @override
  String toString() => 'YouTubeItemId(videoId: $videoId)';

  @override
  bool operator ==(covariant YouTubeItemId other) {
    if (identical(this, other)) {
      return true;
    }

    return other.videoId == videoId;
  }

  @override
  int get hashCode => videoId.hashCode;
}
