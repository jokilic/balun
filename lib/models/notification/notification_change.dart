enum NotificationChangeType {
  matchStarted,
  goal,
  halfTime,
  extraTime,
  penalties,
  fullTime,
}

class NotificationChange {
  final int? fixtureId;
  final NotificationChangeType? type;
  final String? title;
  final String? body;
  final String? summaryLine;
  final String? payload;
  final String? homeLogoUrl;
  final String? awayLogoUrl;

  NotificationChange({
    required this.fixtureId,
    required this.type,
    required this.title,
    required this.body,
    required this.summaryLine,
    this.payload,
    this.homeLogoUrl,
    this.awayLogoUrl,
  });

  @override
  String toString() =>
      'NotificationChange(fixtureId: $fixtureId, type: $type, title: $title, body: $body, summaryLine: $summaryLine, payload: $payload, homeLogoUrl: $homeLogoUrl, awayLogoUrl: $awayLogoUrl)';

  @override
  bool operator ==(covariant NotificationChange other) {
    if (identical(this, other)) {
      return true;
    }

    return other.fixtureId == fixtureId &&
        other.type == type &&
        other.title == title &&
        other.body == body &&
        other.summaryLine == summaryLine &&
        other.payload == payload &&
        other.homeLogoUrl == homeLogoUrl &&
        other.awayLogoUrl == awayLogoUrl;
  }

  @override
  int get hashCode => fixtureId.hashCode ^ type.hashCode ^ title.hashCode ^ body.hashCode ^ summaryLine.hashCode ^ payload.hashCode ^ homeLogoUrl.hashCode ^ awayLogoUrl.hashCode;
}
