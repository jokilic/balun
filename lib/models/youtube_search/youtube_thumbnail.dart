class YouTubeThumbnail {
  final String url;
  final int width;
  final int height;

  YouTubeThumbnail({
    required this.url,
    required this.width,
    required this.height,
  });

  factory YouTubeThumbnail.fromMap(Map<String, dynamic> map) => YouTubeThumbnail(
        url: map['url'] as String,
        width: map['width'] as int,
        height: map['height'] as int,
      );

  @override
  String toString() => 'YouTubeThumbnail(url: $url, width: $width, height: $height)';

  @override
  bool operator ==(covariant YouTubeThumbnail other) {
    if (identical(this, other)) {
      return true;
    }

    return other.url == url && other.width == width && other.height == height;
  }

  @override
  int get hashCode => url.hashCode ^ width.hashCode ^ height.hashCode;
}
