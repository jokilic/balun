import '../constants.dart';
import '../models/fixtures/fixture_response.dart';

Map<String, Map<String, List<FixtureResponse>>> groupFixtures(
  List<FixtureResponse> fixtures,
) {
  final groupedData = <String, Map<String, List<FixtureResponse>>>{};

  for (final fixture in fixtures) {
    if (fixture.league != null) {
      final country = fixture.league!.country ?? 'Unknown';
      final leagueName = fixture.league!.name ?? 'Unknown';

      /// Create country group if it doesn't exist
      groupedData.putIfAbsent(country, () => {});

      /// Create league group if it doesn't exist
      groupedData[country]?.putIfAbsent(leagueName, () => []);

      // Add the current fixture to the appropriate group
      groupedData[country]?[leagueName]?.add(fixture);
    }
  }

  return groupedData;
}

Map<String, Map<String, List<FixtureResponse>>> sortGroupedFixtures(
  Map<String, Map<String, List<FixtureResponse>>> groupedFixtures,
) {
  const countryOrder = BalunConstants.countriesOrder;
  const leagueOrder = BalunConstants.leaguesOrder;

  /// Sort countries
  final sortedCountries = groupedFixtures.entries.toList()
    ..sort(
      (a, b) {
        final priorityA = countryOrder[a.key] ?? countryOrder.length;
        final priorityB = countryOrder[b.key] ?? countryOrder.length;

        return priorityA != priorityB ? priorityA.compareTo(priorityB) : a.key.compareTo(b.key);
      },
    );

  //& Sort leagues within each country
  final sortedGroupedFixtures = Map.fromEntries(
    sortedCountries.map(
      (countryEntry) {
        final sortedLeagues = countryEntry.value.entries.toList()
          ..sort(
            (a, b) {
              final priorityA = leagueOrder[a.key] ?? leagueOrder.length;
              final priorityB = leagueOrder[b.key] ?? leagueOrder.length;

              return priorityA != priorityB ? priorityA.compareTo(priorityB) : a.key.compareTo(b.key);
            },
          );

        return MapEntry(
          countryEntry.key,
          Map.fromEntries(sortedLeagues),
        );
      },
    ),
  );

  return sortedGroupedFixtures;
}
