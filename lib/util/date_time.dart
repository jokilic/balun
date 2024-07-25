import 'package:timeago/timeago.dart' as timeago;

DateTime? parseTimestamp(DateTime? timestamp) {
  if (timestamp == null) {
    return null;
  }

  return timestamp.toLocal();
}

String? parseDateTimeago(DateTime? dateTime) {
  if (dateTime == null) {
    return null;
  }

  /// Format `DateTime` using `timeago` package
  final timeagoDateTime = timeago.format(dateTime);
  return timeagoDateTime;
}
