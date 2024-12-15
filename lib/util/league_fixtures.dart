import 'package:collection/collection.dart';

import '../models/fixtures/fixture_response.dart';
import 'string.dart';

({Map<String, List<FixtureResponse>> pastGroups, Map<String, List<FixtureResponse>> futureGroups}) splitAndGroupLeagueFixtures(
  List<FixtureResponse> fixtures, {
  required DateTime currentDate,
}) {
  /// First group all fixtures
  final allGroups = groupLeagueFixtures(fixtures);

  final pastGroups = <String, List<FixtureResponse>>{};
  final futureGroups = <String, List<FixtureResponse>>{};

  /// Iterate through each group to determine if it contains any future or live matches
  for (final entry in allGroups.entries) {
    final groupHasFutureOrLiveMatch = entry.value.any((fixture) {
      final timestamp = fixture.fixture?.timestamp ?? DateTime(0);
      final status = fixture.fixture?.status?.short;

      /// Check if match is in future or is currently playing
      return timestamp.isAfter(currentDate) ||
          timestamp.isAtSameMomentAs(currentDate) ||
          isMatchPlaying(statusShort: status ?? '--') ||
          isMatchNotStarted(statusShort: status ?? '--');
    });

    if (groupHasFutureOrLiveMatch) {
      futureGroups[entry.key] = entry.value;
    } else {
      pastGroups[entry.key] = entry.value;
    }
  }

  return (
    pastGroups: pastGroups,
    futureGroups: futureGroups,
  );
}

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
