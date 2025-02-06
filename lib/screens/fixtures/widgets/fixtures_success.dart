import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../models/fixtures/fixture_response.dart';
import '../../../models/fixtures/league/league.dart';
import '../../../routing.dart';
import '../../../services/league_storage_service.dart';
import '../../../services/team_storage_service.dart';
import '../../../theme/theme.dart';
import '../../../util/date_time.dart';
import '../../../util/dependencies.dart';
import '../../../util/fixtures.dart';
import 'fixtures_all_dialog.dart';
import 'fixtures_app_bar.dart';
import 'fixtures_favorite_dialog.dart';
import 'fixtures_list_tile/fixtures_country/fixtures_country_list_tile.dart';
import 'fixtures_list_tile/fixtures_league_compact/fixtures_league_compact_list_tile.dart';

class FixturesSuccess extends WatchingWidget {
  final List<FixtureResponse> fixtures;
  final Future<void> Function() onRefresh;

  const FixturesSuccess({
    required this.fixtures,
    required this.onRefresh,
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

    final favoriteFixtures = getFavoriteFixtures(
      fixtures: fixtures,
      favoritedLeagues: favoritedLeagues,
      favoritedTeams: favoritedTeams,
    );

    final favoriteSortedGroupedFixturesLeague = sortGroupedFixturesWithLeagues(
      groupedFixtures: groupFixturesWithLeagues(
        fixtures: favoriteFixtures,
      ),
      favoritedLeagues: favoritedLeagues,
      favoritedTeams: favoritedTeams,
    );

    final sortedGroupedFixtures = sortGroupedFixturesWithCountries(
      groupedFixtures: groupFixturesWithCountries(
        fixtures: fixtures,
      ),
      favoritedLeagues: favoritedLeagues,
      favoritedTeams: favoritedTeams,
    );

    return RefreshIndicator(
      backgroundColor: context.colors.white,
      color: context.colors.green,
      strokeWidth: 3.5,
      onRefresh: onRefresh,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        physics: const BouncingScrollPhysics(),
        children: [
          ///
          /// FAVORITE FIXTURES COMPACT
          ///
          if (favoriteSortedGroupedFixturesLeague.isNotEmpty) ...[
            const SizedBox(height: 8),
            FixturesAppBar(
              onPressed: () => showDialog(
                context: context,
                barrierColor: context.colors.black.withValues(alpha: 0.5),
                builder: (context) => FixturesFavoriteDialog(
                  onPressed: Navigator.of(context).pop,
                  onReorderLeagues: getIt.get<LeagueStorageService>().reorderLeagues,
                  onReorderTeams: getIt.get<TeamStorageService>().reorderTeams,
                ),
              ),
              text: 'fixturesFavoriteTitle'.tr(),
            ),
            const SizedBox(height: 24),
            ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: favoriteSortedGroupedFixturesLeague.length,
              itemBuilder: (_, leagueIndex) {
                final league = favoriteSortedGroupedFixturesLeague.keys.elementAtOrNull(leagueIndex);
                final fixtures = favoriteSortedGroupedFixturesLeague[league];

                return FixturesLeagueCompactListTile(
                  onPressed: league?.id != null
                      ? () => openLeague(
                            context,
                            leagueId: league?.id ?? 0,
                            season: league?.season ?? fixtures?.firstWhereOrNull((fixture) => fixture.league?.season != null)?.league?.season ?? getCurrentSeasonYear().toString(),
                          )
                      : null,
                  league: league,
                  fixtures: fixtures,
                  hasLiveFixturesLeague: hasLiveFixturesLeague(
                    fixtures: fixtures,
                  ),
                  initiallyExpanded: true,
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
              height: favoriteSortedGroupedFixturesLeague.isNotEmpty ? 40 : 8,
            ),
            FixturesAppBar(
              onPressed: () => showDialog(
                context: context,
                barrierColor: context.colors.black.withValues(alpha: 0.5),
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
      ),
    );
  }
}
