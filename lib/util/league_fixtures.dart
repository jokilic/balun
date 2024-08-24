import '../models/fixtures/fixture_response.dart';

int compareLeagueFixturesRounds(String a, String b) {
  /// Extract numbers from Strings if they exist
  final regexNumber = RegExp(r'\d+');

  final aMatch = regexNumber.firstMatch(a);
  final bMatch = regexNumber.firstMatch(b);

  /// Both strings contain numbers, compare them numerically
  if (aMatch != null && bMatch != null) {
    return int.parse(aMatch.group(0)!).compareTo(
      int.parse(bMatch.group(0)!),
    );
  }

  /// Only `a` contains a number, it should come first
  else if (aMatch != null) {
    return -1;
  }

  /// Only `b` contains a number, it should come first
  else if (bMatch != null) {
    return 1;
  }

  /// Neither String contains a number, compare alphabetically
  else {
    return a.compareTo(b);
  }
}

Map<String, List<FixtureResponse>> getGroupedLeagueFixtures(List<FixtureResponse> fixtures) {
  final groupedFixtures = groupLeagueFixtures(fixtures);

  final sortedGroupedFixtures = Map.fromEntries(
    groupedFixtures.entries.toList()
      ..sort(
        (a, b) => compareLeagueFixturesRounds(a.key, b.key),
      ),
  );

  return sortedGroupedFixtures;
}

Map<String, List<FixtureResponse>> groupLeagueFixtures(List<FixtureResponse> fixtures) => fixtures.fold<Map<String, List<FixtureResponse>>>(
      {},
      (map, fixture) {
        final round = fixture.league?.round;

        if (!map.containsKey(round)) {
          map[round!] = [];
        }

        map[round]!.add(fixture);

        return map;
      },
    );
