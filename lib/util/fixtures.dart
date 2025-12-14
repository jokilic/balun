import '../constants.dart';
import '../models/fixtures/fixture_response.dart';
import '../models/fixtures/league/league.dart';
import '../models/matches/favorite_match.dart';
import '../models/teams/team/team.dart';
import 'string.dart';

///
/// FIXTURES DATE PICKER
///

int getPageForActiveDate({
  required List<DateTime> dates,
  required DateTime value,
}) {
  final activeDateIndex = dates.indexWhere(
    (date) => date == value,
  );

  if (activeDateIndex == -1) {
    return 0;
  }

  return activeDateIndex + 1;
}

///
/// FAVORITE FIXTURES
///

List<FixtureResponse> getFavoriteFixtures({
  required List<FixtureResponse> fixtures,
  required List<League> favoritedLeagues,
  required List<Team> favoritedTeams,
  required List<FavoriteMatch> favoritedMatches,
  bool includeFavoritedMatches = true,
}) {
  final favoriteLeagueIds = favoritedLeagues.map((league) => league.id).whereType<int>().toSet();
  final favoriteTeamIds = favoritedTeams.map((team) => team.id).whereType<int>().toSet();
  final favoriteMatchIds = favoritedMatches.map((match) => match.matchId).whereType<int>().toSet();

  return fixtures
      .where(
        (fixture) {
          final leagueId = fixture.league?.id;
          final homeId = fixture.teams?.home?.id;
          final awayId = fixture.teams?.away?.id;
          final matchId = fixture.fixture?.id;

          final isFavoriteLeagueOrTeam = (leagueId != null && favoriteLeagueIds.contains(leagueId)) ||
              (homeId != null && favoriteTeamIds.contains(homeId)) ||
              (awayId != null && favoriteTeamIds.contains(awayId));
          final isFavoriteMatch = matchId != null && favoriteMatchIds.contains(matchId);

          if (!includeFavoritedMatches && isFavoriteMatch && !isFavoriteLeagueOrTeam) {
            return false;
          }

          return isFavoriteLeagueOrTeam || (includeFavoritedMatches && isFavoriteMatch);
        },
      )
      .toList();
}

List<FixtureResponse> getFavoriteMatchFixtures({
  required List<FixtureResponse> fixtures,
  required List<FavoriteMatch> favoritedMatches,
}) {
  final favoriteMatchIds = favoritedMatches.map((match) => match.matchId).whereType<int>().toSet();

  return fixtures
      .where(
        (fixture) {
          final matchId = fixture.fixture?.id;

          return matchId != null && favoriteMatchIds.contains(matchId);
        },
      )
      .toList();
}

///
/// FIXTURES
///

Map<League, Map<League, List<FixtureResponse>>> groupFixturesWithCountries({
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

Map<League, Map<League, List<FixtureResponse>>> sortGroupedFixturesWithCountries({
  required Map<League, Map<League, List<FixtureResponse>>> groupedFixtures,
  required List<League> favoritedLeagues,
  required List<Team> favoritedTeams,
  required List<FavoriteMatch> favoritedMatches,
}) {
  const countryIDs = BalunConstants.favoriteCountryIDs;
  final favoritedTeamIds = favoritedTeams.map((team) => team.id).whereType<int>().toSet();
  final favoritedMatchIds = favoritedMatches.map((match) => match.matchId).whereType<int>().toSet();
  final favoritedLeaguePriority = <int, int>{};

  for (var i = 0; i < favoritedLeagues.length; i++) {
    final id = favoritedLeagues[i].id;

    if (id != null && !favoritedLeaguePriority.containsKey(id)) {
      favoritedLeaguePriority[id] = i;
    }
  }

  bool hasFavoritedTeam(FixtureResponse fixture) {
    final homeId = fixture.teams?.home?.id;
    final awayId = fixture.teams?.away?.id;

    return (homeId != null && favoritedTeamIds.contains(homeId)) || (awayId != null && favoritedTeamIds.contains(awayId));
  }

  bool isFavoritedMatch(FixtureResponse fixture) => favoritedMatchIds.contains(fixture.fixture?.id);
  int leaguePriority(League league) => league.id != null ? (favoritedLeaguePriority[league.id] ?? favoritedLeagues.length) : favoritedLeagues.length;

  /// Sort countries
  final sortedCountries = groupedFixtures.entries.toList()
    ..sort(
      (a, b) {
        /// Check if countries are in the `countryIDs` list
        final isAFavorite = countryIDs.contains(a.key.country);
        final isBFavorite = countryIDs.contains(b.key.country);

        if (isAFavorite && isBFavorite) {
          /// Both countries are favorite, sort by their order in `countryIDs`
          return countryIDs
              .indexOf(a.key.country!)
              .compareTo(
                countryIDs.indexOf(b.key.country!),
              );
        }
        /// Only A is favorite, it should come first
        else if (isAFavorite) {
          return -1;
        }
        /// Only B is favorite, it should come first
        else if (isBFavorite) {
          return 1;
        }
        /// Neither country is favorite, sort alphabetically
        else {
          return a.key.country!.compareTo(b.key.country!);
        }
      },
    );

  /// Sort leagues within each country
  final sortedGroupedFixtures = Map.fromEntries(
    sortedCountries.map(
      (countryEntry) {
        final sortedLeagues = countryEntry.value.entries.toList()
          ..sort(
            (a, b) {
              final matchPriorityA = a.value.any(isFavoritedMatch);
              final matchPriorityB = b.value.any(isFavoritedMatch);

              if (matchPriorityA != matchPriorityB) {
                return matchPriorityA ? -1 : 1;
              }

              final teamPriorityA = a.value.any(hasFavoritedTeam);
              final teamPriorityB = b.value.any(hasFavoritedTeam);

              if (teamPriorityA != teamPriorityB) {
                return teamPriorityA ? -1 : 1;
              }

              final priorityA = leaguePriority(a.key);
              final priorityB = leaguePriority(b.key);

              if (priorityA != priorityB) {
                return priorityA.compareTo(priorityB);
              }

              return a.key.id!.compareTo(b.key.id!);
            },
          );

        /// Sort fixtures within each league by team priority
        final sortedFixtures = Map.fromEntries(
          sortedLeagues.map(
            (leagueEntry) {
              final sortedFixturesList = leagueEntry.value
                ..sort(
                  (a, b) {
                    final isFavoritedMatchA = isFavoritedMatch(a);
                    final isFavoritedMatchB = isFavoritedMatch(b);

                    if (isFavoritedMatchA != isFavoritedMatchB) {
                      return isFavoritedMatchA ? -1 : 1;
                    }

                    final priorityA = hasFavoritedTeam(a);
                    final priorityB = hasFavoritedTeam(b);

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

Map<League, List<FixtureResponse>> groupFixturesWithLeagues({
  required List<FixtureResponse> fixtures,
}) {
  final groupedData = <League, List<FixtureResponse>>{};

  for (final fixture in fixtures) {
    if (fixture.league != null) {
      final league = fixture.league!;

      /// Find or create the league entry
      final leagueKey = League(
        id: league.id,
        name: league.name,
        country: league.country,
        flag: league.flag,
        logo: league.logo,
      );

      /// Add the current fixture to the appropriate group
      groupedData.putIfAbsent(leagueKey, () => []).add(fixture);
    }
  }

  return groupedData;
}

Map<League, List<FixtureResponse>> sortGroupedFixturesWithLeagues({
  required Map<League, List<FixtureResponse>> groupedFixtures,
  required List<League> favoritedLeagues,
  required List<Team> favoritedTeams,
  required List<FavoriteMatch> favoritedMatches,
}) {
  final favoritedMatchIds = favoritedMatches.map((match) => match.matchId).whereType<int>().toSet();
  final favoritedTeamPriority = <int, int>{};
  final favoritedLeaguePriority = <int, int>{};

  for (var i = 0; i < favoritedTeams.length; i++) {
    final id = favoritedTeams[i].id;

    if (id != null && !favoritedTeamPriority.containsKey(id)) {
      favoritedTeamPriority[id] = i;
    }
  }

  for (var i = 0; i < favoritedLeagues.length; i++) {
    final id = favoritedLeagues[i].id;

    if (id != null && !favoritedLeaguePriority.containsKey(id)) {
      favoritedLeaguePriority[id] = i;
    }
  }

  bool hasFavoritedTeam(FixtureResponse fixture) {
    final homeId = fixture.teams?.home?.id;
    final awayId = fixture.teams?.away?.id;

    return (homeId != null && favoritedTeamPriority.containsKey(homeId)) || (awayId != null && favoritedTeamPriority.containsKey(awayId));
  }

  bool isFavoritedMatch(FixtureResponse fixture) => favoritedMatchIds.contains(fixture.fixture?.id);
  int leaguePriority(League league) => league.id != null ? (favoritedLeaguePriority[league.id] ?? favoritedLeagues.length) : favoritedLeagues.length;

  int bestTeamPriority(FixtureResponse fixture) {
    var best = favoritedTeams.length;
    final homeId = fixture.teams?.home?.id;

    if (homeId != null) {
      final priority = favoritedTeamPriority[homeId];

      if (priority != null && priority < best) {
        best = priority;
      }
    }

    final awayId = fixture.teams?.away?.id;

    if (awayId != null) {
      final priority = favoritedTeamPriority[awayId];

      if (priority != null && priority < best) {
        best = priority;
      }
    }

    return best;
  }

  /// Sort leagues
  final sortedLeagues = groupedFixtures.entries.toList()
    ..sort(
      (a, b) {
        final matchPriorityA = a.value.any(isFavoritedMatch);
        final matchPriorityB = b.value.any(isFavoritedMatch);

        if (matchPriorityA != matchPriorityB) {
          return matchPriorityA ? -1 : 1;
        }

        final teamPriorityA = a.value.any(hasFavoritedTeam);
        final teamPriorityB = b.value.any(hasFavoritedTeam);

        if (teamPriorityA != teamPriorityB) {
          return teamPriorityA ? -1 : 1;
        }

        final priorityA = leaguePriority(a.key);
        final priorityB = leaguePriority(b.key);

        if (priorityA != priorityB) {
          return priorityA.compareTo(priorityB);
        }

        return a.key.id!.compareTo(b.key.id!);
      },
    );

  /// Sort fixtures within each league by team priority
  final sortedGroupedFixtures = Map.fromEntries(
    sortedLeagues.map(
      (leagueEntry) {
        final sortedFixturesList = leagueEntry.value
          ..sort(
            (a, b) {
              final isFavoritedMatchA = isFavoritedMatch(a);
              final isFavoritedMatchB = isFavoritedMatch(b);

              if (isFavoritedMatchA != isFavoritedMatchB) {
                return isFavoritedMatchA ? -1 : 1;
              }

              final bestIndexA = bestTeamPriority(a);
              final bestIndexB = bestTeamPriority(b);

              /// If both fixtures have favorited teams, sort by best index
              if (bestIndexA != favoritedTeams.length && bestIndexB != favoritedTeams.length) {
                return bestIndexA.compareTo(bestIndexB);
              }

              /// If only one fixture has a favorited team, prioritize it
              if (bestIndexA != favoritedTeams.length || bestIndexB != favoritedTeams.length) {
                return bestIndexA == favoritedTeams.length ? 1 : -1;
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

  return sortedGroupedFixtures;
}

bool hasLiveFixturesCountry({
  required Map<League, List<FixtureResponse>>? leagues,
}) =>
    leagues?.entries.any(
      (league) => league.value.any(
        (fixture) => isMatchPlaying(
          statusShort: fixture.fixture?.status?.short ?? '--',
        ),
      ),
    ) ??
    false;

bool hasLiveFixturesLeague({
  required List<FixtureResponse>? fixtures,
}) =>
    fixtures?.any(
      (fixture) => isMatchPlaying(
        statusShort: fixture.fixture?.status?.short ?? '--',
      ),
    ) ??
    false;

Map<League, List<FixtureResponse>> groupLeagueFixtures({
  required List<FixtureResponse> fixtures,
}) {
  final groupedData = <League, List<FixtureResponse>>{};

  for (final fixture in fixtures) {
    if (fixture.league != null) {
      final league = fixture.league!;

      /// Find or create the league entry
      final leagueEntry = groupedData.keys.firstWhere(
        (key) => key.id == league.id,
        orElse: () => League(
          id: league.id,
          name: league.country,
          country: league.country,
          flag: league.flag,
          logo: league.logo,
        ),
      );

      /// Find or create the league group
      groupedData[leagueEntry]!
      /// Add the current fixture to the appropriate group
      .add(fixture);
    }
  }

  return groupedData;
}
