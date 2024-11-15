import 'package:collection/collection.dart';

import '../models/fixtures/fixture_response.dart';

Map<String, List<FixtureResponse>> groupLeagueFixtures(List<FixtureResponse> fixtures) {
  final grouped = groupBy(
    fixtures,
    (fixture) => fixture.league?.round ?? '',
  );

  final sortedEntries = grouped.entries.toList()
    ..sort((a, b) {
      final aFirst = getFirstTimestamp(a.value);
      final bFirst = getFirstTimestamp(b.value);

      return aFirst.compareTo(bFirst);
    });

  return Map.fromEntries(
    sortedEntries.map(
      (entry) => MapEntry(
        entry.key,
        List<FixtureResponse>.from(entry.value)
          ..sort(
            (a, b) {
              final timeA = a.fixture?.timestamp ?? DateTime(0);
              final timeB = b.fixture?.timestamp ?? DateTime(0);
              return timeA.compareTo(timeB);
            },
          ),
      ),
    ),
  );
}

DateTime getFirstTimestamp(List<FixtureResponse> matches) {
  if (matches.isEmpty) {
    return DateTime(0);
  }

  var firstTimestamp = matches.first.fixture?.timestamp ?? DateTime(0);

  for (final match in matches) {
    final timestamp = match.fixture?.timestamp ?? DateTime(0);
    if (timestamp.isBefore(firstTimestamp)) {
      firstTimestamp = timestamp;
    }
  }
  return firstTimestamp;
}
