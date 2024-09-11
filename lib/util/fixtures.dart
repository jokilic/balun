import '../constants.dart';
import '../models/fixtures/fixture_response.dart';
import '../models/fixtures/league/league.dart';

///
/// POPULAR FIXTURES
///

List<FixtureResponse> getPopularFixtures({
  required List<FixtureResponse> fixtures,
  required List<League> favoritedLeagues,
}) =>
    fixtures
        .where(
          (fixture) => favoritedLeagues.any(
            (league) => fixture.league?.id == league.id,
          ),
        )
        .toList();

Map<League, List<FixtureResponse>> groupPopularFixtures(
  List<FixtureResponse> fixtures,
) {
  final groupedData = <League, List<FixtureResponse>>{};

  for (final fixture in fixtures) {
    if (fixture.league != null) {
      final league = fixture.league!;

      final newLeague = League(
        id: league.id,
        name: league.name,
        country: league.country,
        flag: league.flag,
        logo: league.logo,
      );

      /// Create league group if it doesn't exist
      groupedData.putIfAbsent(
        newLeague,
        () => [],
      );

      /// Add the current fixture to the appropriate group
      groupedData[newLeague]!.add(fixture);
    }
  }

  return groupedData;
}

///
/// FIXTURES
///

Map<League, Map<League, List<FixtureResponse>>> groupFixtures({
  required List<FixtureResponse> fixtures,
}) {
  final groupedData = <League, Map<League, List<FixtureResponse>>>{};

  for (final fixture in fixtures) {
    if (fixture.league != null) {
      final league = fixture.league!;

      /// Find or create the country entry
      final countryLeague = groupedData.keys.firstWhere(
        (key) => key.country == league.country,
        orElse: () {
          final newCountryLeague = League(
            id: league.id,
            name: league.country,
            country: league.country,
            flag: league.flag,
            logo: league.logo,
          );

          groupedData[newCountryLeague] = {};

          return newCountryLeague;
        },
      );

      /// Find or create the league group
      groupedData[countryLeague]!
          .putIfAbsent(
            League(
              id: league.id,
              name: league.name,
              country: league.country,
              flag: league.flag,
              logo: league.logo,
            ),
            () => [],
          )

          /// Add the current fixture to the appropriate group
          .add(fixture);
    }
  }

  return groupedData;
}

Map<League, Map<League, List<FixtureResponse>>> sortGroupedFixtures({
  required Map<League, Map<League, List<FixtureResponse>>> groupedFixtures,
  required List<League> favoritedLeagues,
}) {
  const countryOrder = BalunConstants.popularCountryIDs;

  /// Sort countries
  final sortedCountries = groupedFixtures.entries.toList()
    ..sort(
      (a, b) {
        final priorityA = a.key.country != null ? countryOrder.indexOf(a.key.country!) : countryOrder.length;
        final priorityB = b.key.country != null ? countryOrder.indexOf(b.key.country!) : countryOrder.length;

        return priorityA != priorityB ? priorityA.compareTo(priorityB) : a.key.country!.compareTo(b.key.country!);
      },
    );

  /// Sort leagues within each country
  final sortedGroupedFixtures = Map.fromEntries(
    sortedCountries.map(
      (countryEntry) {
        final sortedLeagues = countryEntry.value.entries.toList()
          ..sort(
            (a, b) {
              final priorityA = a.key.id != null ? favoritedLeagues.indexWhere((league) => league.id == a.key.id) : favoritedLeagues.length;
              final priorityB = b.key.id != null ? favoritedLeagues.indexWhere((league) => league.id == b.key.id) : favoritedLeagues.length;

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

bool shouldShowTimeBeforeMatch({required String statusShort}) => statusShort == 'TBD' || statusShort == 'NS';
