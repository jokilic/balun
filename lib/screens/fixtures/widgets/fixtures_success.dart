import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../models/fixtures/fixture_response.dart';
import '../../../models/fixtures/league/league.dart';
import '../../../services/league_storage_service.dart';
import '../../../services/team_storage_service.dart';
import '../../../util/fixtures.dart';
import 'fixtures_app_bar.dart';
import 'fixtures_list_tile/fixtures_country/fixtures_country_list_tile.dart';

class FixturesSuccess extends WatchingWidget {
  final List<FixtureResponse> fixtures;

  const FixturesSuccess({
    required this.fixtures,
  });

  @override
  Widget build(BuildContext context) {
    final favoritedLeagues = watchIt<LeagueStorageService>()
        .value
        .map(
          (league) => League(
            id: league.id,
            name: league.name,
            logo: league.logo,
          ),
        )
        .toList();

    final favoritedTeams = watchIt<TeamStorageService>().value;

    final popularSortedGroupedFixtures = sortGroupedFixtures(
      groupedFixtures: groupFixtures(
        fixtures: getPopularFixtures(
          fixtures: fixtures,
          favoritedLeagues: favoritedLeagues,
          favoritedTeams: favoritedTeams,
        ),
      ),
      favoritedLeagues: favoritedLeagues,
      favoritedTeams: favoritedTeams,
    );

    final sortedGroupedFixtures = sortGroupedFixtures(
      groupedFixtures: groupFixtures(
        fixtures: fixtures,
      ),
      favoritedLeagues: favoritedLeagues,
      favoritedTeams: favoritedTeams,
    );

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      physics: const BouncingScrollPhysics(),
      children: [
        ///
        /// POPULAR FIXTURES
        ///
        if (popularSortedGroupedFixtures.isNotEmpty) ...[
          const SizedBox(height: 8),
          FixturesAppBar(
            onPressed: () {},
            text: 'Favorite matches',
          ),
          const SizedBox(height: 24),
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: popularSortedGroupedFixtures.length,
            itemBuilder: (_, countryIndex) {
              final countryLeague = popularSortedGroupedFixtures.keys.elementAtOrNull(countryIndex);
              final leagues = popularSortedGroupedFixtures[countryLeague];

              return FixturesCountryListTile(
                countryLeague: countryLeague,
                leagues: leagues,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
          ),
        ],

        ///
        /// ALL MATCHES
        ///
        if (sortedGroupedFixtures.isNotEmpty) ...[
          SizedBox(
            height: popularSortedGroupedFixtures.isNotEmpty ? 40 : 8,
          ),
          FixturesAppBar(
            onPressed: () {},
            text: 'All matches',
          ),
          const SizedBox(height: 24),
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sortedGroupedFixtures.length,
            itemBuilder: (_, countryIndex) {
              final countryLeague = sortedGroupedFixtures.keys.elementAtOrNull(countryIndex);
              final leagues = sortedGroupedFixtures[countryLeague];

              return FixturesCountryListTile(
                countryLeague: countryLeague,
                leagues: leagues,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
          ),
        ],
      ],
    );
  }
}
