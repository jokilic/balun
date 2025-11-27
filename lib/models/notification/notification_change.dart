enum NotificationChangeType {
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

  NotificationChange({
    required this.fixtureId,
    required this.type,
    required this.title,
    required this.body,
    required this.summaryLine,
    this.payload,
  });

  @override
  String toString() => 'NotificationChange(fixtureId: $fixtureId, type: $type, title: $title, body: $body, summaryLine: $summaryLine, payload: $payload)';

  @override
  bool operator ==(covariant NotificationChange other) {
    if (identical(this, other)) {
      return true;
    }

    return other.fixtureId == fixtureId && other.type == type && other.title == title && other.body == body && other.summaryLine == summaryLine && other.payload == payload;
  }

  @override
  int get hashCode => fixtureId.hashCode ^ type.hashCode ^ title.hashCode ^ body.hashCode ^ summaryLine.hashCode ^ payload.hashCode;
}
