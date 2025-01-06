import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

String getDateForBackend(DateTime dateTime) {
  final year = dateTime.year.toString().padLeft(2, '0');
  final month = dateTime.month.toString().padLeft(2, '0');
  final day = dateTime.day.toString().padLeft(2, '0');

  return '$year-$month-$day';
}

int getCurrentSeasonYear() {
  final now = DateTime.now();

  final currentYear = now.year;
  final currentMonth = now.month;

  /// Most football seasons start around `August - September`
  /// If we're in the early months of the year, we should return the previous year
  const seasonStartMonth = 8; // August

  if (currentMonth < seasonStartMonth) {
    return currentYear - 1;
  }

  return currentYear;
}

DateTime? parseTimestamp(DateTime? timestamp) {
  if (timestamp == null) {
    return null;
  }

  return timestamp.toLocal();
}

String? parseDateTimeago(
  DateTime? timestamp, {
  required BuildContext context,
}) {
  /// Parse timestamp
  final parsedTimestamp = parseTimestamp(timestamp);

  if (parsedTimestamp == null) {
    return null;
  }

  /// Format `DateTime` using `timeago` package
  final timeagoDateTime = timeago.format(
    parsedTimestamp,
    allowFromNow: true,
    locale: context.locale.toLanguageTag(),
  );
  return timeagoDateTime;
}
