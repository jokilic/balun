import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../models/fixtures/fixture_response.dart';
import '../../../models/fixtures/league/league.dart';
import '../../../services/league_storage_service.dart';
import '../../../services/team_storage_service.dart';
import '../../../theme/theme.dart';
import '../../../util/fixtures.dart';
import 'fixtures_all_dialog.dart';
import 'fixtures_app_bar.dart';
import 'fixtures_favorite_dialog.dart';
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

    final favoriteSortedGroupedFixtures = sortGroupedFixtures(
      groupedFixtures: groupFixtures(
        fixtures: getFavoriteFixtures(
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
        /// FAVORITE FIXTURES
        ///
        if (favoriteSortedGroupedFixtures.isNotEmpty) ...[
          const SizedBox(height: 8),
          FixturesAppBar(
            onPressed: () => showDialog(
              context: context,
              barrierColor: context.colors.black.withOpacity(0.5),
              builder: (context) => FixturesFavoriteDialog(
                onPressed: Navigator.of(context).pop,
              ),
            ),
            text: 'fixturesFavoriteTitle'.tr(),
          ),
          const SizedBox(height: 24),
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: favoriteSortedGroupedFixtures.length,
            itemBuilder: (_, countryIndex) {
              final countryLeague = favoriteSortedGroupedFixtures.keys.elementAtOrNull(countryIndex);
              final leagues = favoriteSortedGroupedFixtures[countryLeague];

              return FixturesCountryListTile(
                countryLeague: countryLeague,
                leagues: leagues,
                hasLiveFixturesCountry: hasLiveFixturesCountry(
                  leagues: leagues,
                ),
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
            height: favoriteSortedGroupedFixtures.isNotEmpty ? 40 : 8,
          ),
          FixturesAppBar(
            onPressed: () => showDialog(
              context: context,
              barrierColor: context.colors.black.withOpacity(0.5),
              builder: (context) => FixturesAllDialog(
                onPressed: Navigator.of(context).pop,
              ),
            ),
            text: 'fixturesAllTitle'.tr(),
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
                hasLiveFixturesCountry: hasLiveFixturesCountry(
                  leagues: leagues,
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
          ),
        ],
      ],
    );
  }
}
