import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watch_it/watch_it.dart';

import '../../../models/fixtures/fixture_response.dart';
import '../../../models/fixtures/league/league.dart';
import '../../../routing.dart';
import '../../../services/league_storage_service.dart';
import '../../../services/match_storage_service.dart';
import '../../../services/team_storage_service.dart';
import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../util/date_time.dart';
import '../../../util/dependencies.dart';
import '../../../util/fixtures.dart';
import '../../../util/match.dart';
import '../../../util/snackbars.dart';
import '../../../util/string.dart';
import '../../../widgets/ball_refresh_indicator.dart';
import '../controllers/fixtures_controller.dart';
import '../controllers/fixtures_date_controller.dart';
import 'fixtures_all_dialog.dart';
import 'fixtures_app_bar.dart';
import 'fixtures_favorite_dialog.dart';
import 'fixtures_list_tile/fixtures/fixtures_compact_list_tile.dart';
import 'fixtures_list_tile/fixtures_country/fixtures_country_list_tile.dart';
import 'fixtures_list_tile/fixtures_league_compact/fixtures_league_compact_list_tile.dart';

class FixturesSuccess extends WatchingWidget {
  final List<FixtureResponse> fixtures;

  const FixturesSuccess({
    required this.fixtures,
  });

  Future<void> toggleFavorite({
    required FixtureResponse fixture,
    required BuildContext context,
  }) async {
    final matchAdded = await getIt.get<MatchStorageService>().toggleMatch(
      passedMatch: getFavoriteMatch(
        match: fixture,
      ),
    );

    if (matchAdded ?? false) {
      showSnackbar(
        context,
        icon: BalunIcons.notificationMatch,
        text: 'snackbarFavoriteMatch'.tr(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritedLeagues = watchIt<LeagueStorageService>().value
        .map(
          (league) => League(
            id: league.id,
            name: league.name,
            logo: league.logo,
          ),
        )
        .toList();
    final favoritedTeams = watchIt<TeamStorageService>().value;
    final favoritedMatches = watchIt<MatchStorageService>().value;

    /// Favorite match fixtures
    final favoriteFixturesMatch = getFavoriteMatchFixtures(
      fixtures: fixtures,
      favoritedMatches: favoritedMatches,
    );

    /// Favorite team fixtures
    final favoriteFixturesTeam = getFavoriteFixtures(
      fixtures: fixtures,
      favoritedTeams: favoritedTeams,
      favoritedLeagues: const [],
      favoritedMatches: const [],
    );

    /// Favorite league fixtures
    final favoriteFixturesLeague = getFavoriteFixtures(
      fixtures: fixtures,
      favoritedLeagues: favoritedLeagues,
      favoritedTeams: const [],
      favoritedMatches: const [],
    );

    /// Sorting
    final favoriteSortedGroupedFixturesLeague = sortGroupedFixturesWithLeagues(
      groupedFixtures: groupFixturesWithLeagues(
        fixtures: favoriteFixturesLeague,
      ),
      favoritedLeagues: favoritedLeagues,
      favoritedTeams: favoritedTeams,
      favoritedMatches: favoritedMatches,
    );

    /// All fixtures
    final sortedGroupedFixtures = sortGroupedFixturesWithCountries(
      groupedFixtures: groupFixturesWithCountries(
        fixtures: fixtures,
      ),
      favoritedLeagues: favoritedLeagues,
      favoritedTeams: favoritedTeams,
      favoritedMatches: favoritedMatches,
    );

    /// Helpers
    final hasFavoriteLeagues = favoriteSortedGroupedFixturesLeague.isNotEmpty;
    final hasFavoriteTeams = favoriteFixturesTeam.isNotEmpty;
    final hasFavoriteMatches = favoriteFixturesMatch.isNotEmpty;

    final hasFavoriteSections = hasFavoriteLeagues || hasFavoriteTeams || hasFavoriteMatches;

    return BallRefreshIndicator(
      ballColors: [
        context.colors.primaryForeground,
      ],
      backgroundColor: context.colors.primaryBackground,
      arrowColor: context.colors.primaryForeground,
      ballBorderColor: context.colors.primaryForeground,
      ballRadius: 32,
      strokeWidth: 3.5,
      onRefresh: () => getIt
          .get<FixturesController>(
            instanceName: 'fixtures',
          )
          .onRefresh(
            dateString: getDateForBackend(
              getIt
                  .get<FixturesDateController>(
                    instanceName: 'fixtures',
                  )
                  .value,
            ),
            currentDateString: getDateForBackend(
              DateTime.now(),
            ),
          ),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          ///
          /// TOP PADDING
          ///
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),

          ///
          /// FAVORITES COMPACT
          ///
          if (hasFavoriteSections)
            const SliverToBoxAdapter(
              child: SizedBox(height: 8),
            ),

          ///
          /// FAVORITE MATCHES
          ///
          if (hasFavoriteMatches) ...[
            SliverToBoxAdapter(
              child: FixturesAppBar(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => FixturesFavoriteDialog(
                    onPressed: Navigator.of(context).pop,
                    title: 'fixturesFavoriteMatchesTitle'.tr(),
                  ),
                ),
                icon: BalunIcons.placeholderMatch,
                text: 'fixturesFavoriteMatchesTitle'.tr(),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              sliver: SliverList.separated(
                itemCount: favoriteFixturesMatch.length,
                itemBuilder: (_, itemIndex) {
                  final fixture = favoriteFixturesMatch[itemIndex];

                  return FixturesCompactListTile(
                    fixture: fixture,
                    scoreText: getCompactFixtureText(
                      statusShort: fixture.fixture?.status?.short ?? '--',
                      minutes: fixture.fixture?.status?.elapsed ?? 0,
                      extra: fixture.fixture?.status?.extra,
                      timestamp: fixture.fixture?.timestamp,
                      homeGoals: fixture.goals?.home,
                      awayGoals: fixture.goals?.away,
                      context: context,
                    ),
                    fixturePlaying: isMatchPlaying(
                      statusShort: fixture.fixture?.status?.short ?? '--',
                    ),
                    onFixturePressed: fixture.fixture?.id != null
                        ? () {
                            HapticFeedback.lightImpact();
                            openMatch(
                              context,
                              matchId: fixture.fixture!.id!,
                            );
                          }
                        : null,
                    onFixtureLongPressed: () => toggleFavorite(
                      fixture: fixture,
                      context: context,
                    ),
                    isFavorited: favoritedMatches.any(
                      (match) => match.matchId == fixture.fixture?.id,
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 12),
              ),
            ),
            if (hasFavoriteTeams || hasFavoriteLeagues)
              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
          ],

          ///
          /// FAVORITE TEAMS
          ///
          if (hasFavoriteTeams) ...[
            SliverToBoxAdapter(
              child: FixturesAppBar(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => FixturesFavoriteDialog(
                    onPressed: Navigator.of(context).pop,
                    title: 'fixturesFavoriteTeamsTitle'.tr(),
                  ),
                ),
                icon: BalunIcons.placeholderTeam,
                text: 'fixturesFavoriteTeamsTitle'.tr(),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              sliver: SliverList.separated(
                itemCount: favoriteFixturesTeam.length,
                itemBuilder: (_, itemIndex) {
                  final fixture = favoriteFixturesTeam[itemIndex];

                  return FixturesCompactListTile(
                    fixture: fixture,
                    scoreText: getCompactFixtureText(
                      statusShort: fixture.fixture?.status?.short ?? '--',
                      minutes: fixture.fixture?.status?.elapsed ?? 0,
                      extra: fixture.fixture?.status?.extra,
                      timestamp: fixture.fixture?.timestamp,
                      homeGoals: fixture.goals?.home,
                      awayGoals: fixture.goals?.away,
                      context: context,
                    ),
                    fixturePlaying: isMatchPlaying(
                      statusShort: fixture.fixture?.status?.short ?? '--',
                    ),
                    onFixturePressed: fixture.fixture?.id != null
                        ? () {
                            HapticFeedback.lightImpact();
                            openMatch(
                              context,
                              matchId: fixture.fixture!.id!,
                            );
                          }
                        : null,
                    onFixtureLongPressed: () => toggleFavorite(
                      fixture: fixture,
                      context: context,
                    ),
                    isFavorited: favoritedMatches.any(
                      (match) => match.matchId == fixture.fixture?.id,
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 12),
              ),
            ),
            if (hasFavoriteLeagues)
              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
          ],

          ///
          /// FAVORITE LEAGUES
          ///
          if (hasFavoriteLeagues) ...[
            SliverToBoxAdapter(
              child: FixturesAppBar(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => FixturesFavoriteDialog(
                    onPressed: Navigator.of(context).pop,
                    title: 'fixturesFavoriteLeaguesTitle'.tr(),
                  ),
                ),
                icon: BalunIcons.placeholderLeague,
                text: 'fixturesFavoriteLeaguesTitle'.tr(),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              sliver: SliverList.separated(
                itemCount: favoriteSortedGroupedFixturesLeague.length,
                itemBuilder: (_, itemIndex) {
                  final league = favoriteSortedGroupedFixturesLeague.keys.elementAtOrNull(itemIndex);
                  final fixtures = favoriteSortedGroupedFixturesLeague[league];

                  return FixturesLeagueCompactListTile(
                    onPressed: league?.id != null
                        ? () {
                            HapticFeedback.lightImpact();
                            openLeague(
                              context,
                              leagueId: league?.id ?? 0,
                              season:
                                  league?.season ?? fixtures?.firstWhereOrNull((fixture) => fixture.league?.season != null)?.league?.season ?? getCurrentSeasonYear().toString(),
                            );
                          }
                        : null,
                    onFixtureLongPressed: (fixture) => toggleFavorite(
                      fixture: fixture,
                      context: context,
                    ),
                    league: league,
                    fixtures: fixtures,
                    hasLiveFixturesLeague: hasLiveFixturesLeague(
                      fixtures: fixtures,
                    ),
                    initiallyExpanded: true,
                    favoritedMatches: favoritedMatches,
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 12),
              ),
            ),
          ],

          ///
          /// ALL MATCHES
          ///
          if (sortedGroupedFixtures.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: SizedBox(
                height: hasFavoriteSections ? 40 : 8,
              ),
            ),
            SliverToBoxAdapter(
              child: FixturesAppBar(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => FixturesAllDialog(
                    onPressed: Navigator.of(context).pop,
                  ),
                ),
                icon: BalunIcons.ballNavigation,
                text: 'fixturesAllTitle'.tr(),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              sliver: SliverList.separated(
                itemCount: sortedGroupedFixtures.length,
                itemBuilder: (_, countryIndex) {
                  final countryLeague = sortedGroupedFixtures.keys.elementAtOrNull(countryIndex);
                  final leagues = sortedGroupedFixtures[countryLeague];

                  return FixturesCountryListTile(
                    onLongPressedListTile: (league) {
                      if (league?.id != null) {
                        HapticFeedback.lightImpact();
                        openLeague(
                          context,
                          leagueId: league?.id ?? 0,
                          season:
                              league?.season ??
                              leagues?[league]?.firstWhereOrNull((fixture) => fixture.league?.season != null)?.league?.season ??
                              getCurrentSeasonYear().toString(),
                        );
                      }
                    },
                    onFixtureLongPressed: (fixture) => toggleFavorite(
                      fixture: fixture,
                      context: context,
                    ),
                    countryLeague: countryLeague,
                    leagues: leagues,
                    hasLiveFixturesCountry: hasLiveFixturesCountry(
                      leagues: leagues,
                    ),
                    favoritedMatches: favoritedMatches,
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 12),
              ),
            ),
          ],

          ///
          /// BOTTOM PADDING
          ///
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
        ],
      ),
    );
  }
}
