import '../constants.dart';
import '../models/fixtures/fixture_response.dart';
import '../models/fixtures/league/league.dart';
import '../models/teams/team/team.dart';

///
/// POPULAR FIXTURES
///

List<FixtureResponse> getPopularFixtures({
  required List<FixtureResponse> fixtures,
  required List<League> favoritedLeagues,
  required List<Team> favoritedTeams,
}) =>
    fixtures
        .where(
          (fixture) =>
              favoritedLeagues.any(
                (league) => fixture.league?.id == league.id,
              ) ||
              favoritedTeams.any(
                (team) => fixture.teams?.home?.id == team.id || fixture.teams?.away?.id == team.id,
              ),
        )
        .toList();

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
  required List<Team> favoritedTeams,
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
              final priorityA = a.key.id != null
                  ? favoritedLeagues.indexWhere(
                      (league) => league.id == a.key.id,
                    )
                  : favoritedLeagues.length;
              final priorityB = b.key.id != null
                  ? favoritedLeagues.indexWhere(
                      (league) => league.id == b.key.id,
                    )
                  : favoritedLeagues.length;

              if (priorityA != priorityB) {
                return priorityA.compareTo(priorityB);
              }

              /// If leagues have the same priority, sort by team priority
              else {
                final teamPriorityA = a.value.any(
                  (fixture) => favoritedTeams.any(
                    (team) => team.id == fixture.teams?.home?.id || team.id == fixture.teams?.away?.id,
                  ),
                );
                final teamPriorityB = b.value.any(
                  (fixture) => favoritedTeams.any(
                    (team) => team.id == fixture.teams?.home?.id || team.id == fixture.teams?.away?.id,
                  ),
                );

                if (teamPriorityA != teamPriorityB) {
                  return teamPriorityA ? -1 : 1;
                }

                return a.key.id!.compareTo(b.key.id!);
              }
            },
          );

        /// Sort fixtures within each league by team priority
        final sortedFixtures = Map.fromEntries(
          sortedLeagues.map(
            (leagueEntry) {
              final sortedFixturesList = leagueEntry.value
                ..sort(
                  (a, b) {
                    final priorityA = favoritedTeams.any(
                      (team) => team.id == a.teams?.home?.id || team.id == a.teams?.away?.id,
                    );
                    final priorityB = favoritedTeams.any(
                      (team) => team.id == b.teams?.home?.id || team.id == b.teams?.away?.id,
                    );

                    if (priorityA != priorityB) {
                      return priorityA ? -1 : 1;
                    }

                    return 0;
                  },
                );

              return MapEntry(
                leagueEntry.key,
                sortedFixturesList,
              );
            },
          ),
        );

        return MapEntry(
          countryEntry.key,
          sortedFixtures,
        );
      },
    ),
  );

  return sortedGroupedFixtures;
}

bool shouldShowTimeBeforeMatch({required String statusShort}) => statusShort == 'TBD' || statusShort == 'NS';
