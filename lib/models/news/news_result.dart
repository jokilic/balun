class NewsResult {
  final String? title;
  final String? link;
  final String? description;
  final DateTime? pubDate;
  final String? imageUrl;
  final String? sourceName;
  final String? sourceUrl;
  final String? sourceIcon;

  NewsResult({
    this.title,
    this.link,
    this.description,
    this.pubDate,
    this.imageUrl,
    this.sourceName,
    this.sourceUrl,
    this.sourceIcon,
  });

  factory NewsResult.fromMap(Map<String, dynamic> map) => NewsResult(
        title: map['title'] != null ? map['title'] as String : null,
        link: map['link'] != null ? map['link'] as String : null,
        description: map['description'] != null ? map['description'] as String : null,
        pubDate: map['pubDate'] != null ? DateTime.parse(map['pubDate'] as String) : null,
        imageUrl: map['image_url'] != null ? map['image_url'] as String : null,
        sourceName: map['source_name'] != null ? map['source_name'] as String : null,
        sourceUrl: map['source_url'] != null ? map['source_url'] as String : null,
        sourceIcon: map['source_icon'] != null ? map['source_icon'] as String : null,
      );

  @override
  String toString() =>
      'NewsResult(title: $title, link: $link, description: $description, pubDate: $pubDate, imageUrl: $imageUrl, sourceName: $sourceName, sourceUrl: $sourceUrl, sourceIcon: $sourceIcon)';

  @override
  bool operator ==(covariant NewsResult other) {
    if (identical(this, other)) {
      return true;
    }

    return other.title == title;
  }

  @override
  int get hashCode => title.hashCode;
}
