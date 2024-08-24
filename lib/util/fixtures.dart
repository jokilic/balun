import '../constants.dart';
import '../models/fixtures/fixture_response.dart';
import '../models/fixtures/league/league.dart';

Map<League, Map<League, List<FixtureResponse>>> groupFixtures(
  List<FixtureResponse> fixtures,
) {
  final groupedData = <League, Map<League, List<FixtureResponse>>>{};

  for (final fixture in fixtures) {
    if (fixture.league != null) {
      final league = fixture.league!;

      /// Find or create the country entry
      final countryLeague = groupedData.keys.firstWhere(
        (key) => key.country == league.country,
        orElse: () {
          final newCountryLeague = League(
            id: -1,
            country: league.country,
            flag: league.flag,
          );

          groupedData[newCountryLeague] = {};

          return newCountryLeague;
        },
      );

      /// Create league group if it doesn't exist
      groupedData[countryLeague]!.putIfAbsent(league, () => []);

      /// Add the current fixture to the appropriate group
      groupedData[countryLeague]![league]!.add(fixture);
    }
  }

  return groupedData;
}

Map<League, Map<League, List<FixtureResponse>>> sortGroupedFixtures(
  Map<League, Map<League, List<FixtureResponse>>> groupedFixtures,
) {
  const countryOrder = BalunConstants.countriesOrder;
  const leagueOrder = BalunConstants.leaguesOrder;

  /// Sort countries
  final sortedCountries = groupedFixtures.entries.toList()
    ..sort(
      (a, b) {
        final priorityA = countryOrder[a.key.country] ?? countryOrder.length;
        final priorityB = countryOrder[b.key.country] ?? countryOrder.length;

        return priorityA != priorityB ? priorityA.compareTo(priorityB) : a.key.country!.compareTo(b.key.country!);
      },
    );

  //& Sort leagues within each country
  final sortedGroupedFixtures = Map.fromEntries(
    sortedCountries.map(
      (countryEntry) {
        final sortedLeagues = countryEntry.value.entries.toList()
          ..sort(
            (a, b) {
              final priorityA = leagueOrder[a.key.id] ?? leagueOrder.length;
              final priorityB = leagueOrder[b.key.id] ?? leagueOrder.length;

              return priorityA != priorityB ? priorityA.compareTo(priorityB) : a.key.id!.compareTo(b.key.id!);
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
