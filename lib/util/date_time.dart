import 'package:timeago/timeago.dart' as timeago;

DateTime? parseTimestamp(DateTime? timestamp) {
  if (timestamp == null) {
    return null;
  }

  return timestamp.toLocal();
}

String? parseDateTimeago(DateTime? timestamp) {
  /// Parse timestamp
  final parsedTimestamp = parseTimestamp(timestamp);

  if (parsedTimestamp == null) {
    return null;
  }

  /// Format `DateTime` using `timeago` package
  final timeagoDateTime = timeago.format(
    parsedTimestamp,
    allowFromNow: true,
    // locale: context.locale.toLanguageTag(),
  );
  return timeagoDateTime;
}
