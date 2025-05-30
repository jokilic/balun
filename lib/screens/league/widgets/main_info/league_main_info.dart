import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../models/leagues/league_response.dart';
import '../../../../services/league_storage_service.dart';
import '../../../../theme/icons.dart';
import '../../../../theme/theme.dart';
import '../../../../util/dependencies.dart';
import '../../../../util/scroll_configuration.dart';
import '../../../../util/string.dart';
import '../../../../util/word_mix.dart';
import '../../../../widgets/balun_button.dart';
import '../../../../widgets/balun_image/balun_image.dart';
import '../../controllers/league_season_controller.dart';
import '../league_app_bar.dart';

class LeagueMainInfo extends WatchingWidget {
  final LeagueResponse league;

  const LeagueMainInfo({
    required this.league,
  });

  @override
  Widget build(BuildContext context) {
    final seasonState = watchIt<LeagueSeasonController>(
      instanceName: '${league.league?.id}',
    ).value;

    final pageController = getIt
        .get<LeagueSeasonController>(
          instanceName: '${league.league?.id}',
        )
        .controller;

    final favoritedLeagues = watchIt<LeagueStorageService>().value;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),

          ///
          /// BACK & LEAGUE
          ///
          LeagueAppBar(
            onBackPressed: Navigator.of(context).pop,
            league: league.league!,
            onFavoritePressed: () => getIt.get<LeagueStorageService>().toggleLeague(
                  passedLeague: league.league,
                ),
            isFavorited: favoritedLeagues.any(
              (element) => element.id == league.league?.id,
            ),
          ),

          const SizedBox(height: 48),

          ///
          /// LOGO
          ///
          BalunImage(
            imageUrl: league.league?.logo ?? BalunIcons.placeholderLeague,
            height: 120,
            width: 120,
          ),

          const SizedBox(height: 16),

          ///
          /// NAME
          ///
          Text(
            mixOrOriginalWords(league.league?.name ?? '---') ?? '---',
            style: context.textStyles.leagueNameBold,
            textAlign: TextAlign.center,
          ),

          ///
          /// COUNTRY
          ///
          Text(
            league.country?.name != null
                ? mixOrOriginalWords(
                      getCountryName(
                        country: league.country!.name!,
                      ),
                    ) ??
                    '---'
                : '---',
            style: context.textStyles.leagueCountry,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          ///
          /// SEASON TITLE
          ///
          if (league.seasons?.isNotEmpty ?? false) ...[
            Text(
              'leagueInfoSeason'.tr(),
              style: context.textStyles.leagueSeason,
              textAlign: TextAlign.center,
            ),

            ///
            /// SEASONS
            ///
            SizedBox(
              height: 48,
              width: 200,
              child: ScrollConfiguration(
                behavior: BalunScrollConfiguration(),
                child: PageView(
                  controller: pageController,
                  physics: const BouncingScrollPhysics(),
                  children: List.generate(
                    league.seasons?.length ?? 0,
                    (index) {
                      final season = league.seasons![index];

                      return BalunButton(
                        onPressed: () => getIt
                            .get<LeagueSeasonController>(
                              instanceName: '${league.league?.id}',
                            )
                            .updateState(season.year.toString()),
                        child: Center(
                          child: Text(
                            '${season.year ?? '--'}',
                            style: seasonState == season.year.toString() ? context.textStyles.seasonPickerActive : context.textStyles.seasonPickerInactive,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
