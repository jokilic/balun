import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../models/leagues/league_response.dart';
import '../../../../services/league_storage_service.dart';
import '../../../../theme/icons.dart';
import '../../../../theme/theme.dart';
import '../../../../util/dependencies.dart';
import '../../../../util/string.dart';
import '../../../../widgets/balun_button.dart';
import '../../../../widgets/balun_image.dart';
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
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BalunImage(
              imageUrl: league.league?.logo ?? BalunIcons.placeholderLeague,
              height: 120,
              width: 120,
            ),
          ),

          const SizedBox(height: 16),

          ///
          /// NAME
          ///
          Text(
            league.league?.name ?? '---',
            style: context.textStyles.leagueName,
            textAlign: TextAlign.center,
          ),

          ///
          /// COUNTRY
          ///
          Text(
            league.country?.name != null
                ? getCountryName(
                    country: league.country!.name!,
                  )
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
              child: PageView(
                controller: getIt
                    .get<LeagueSeasonController>(
                      instanceName: '${league.league?.id}',
                    )
                    .controller,
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
                          .updateState(season.year),
                      child: Center(
                        child: Text(
                          '${season.year ?? '--'}',
                          style: seasonState == season.year ? context.textStyles.seasonPickerActive : context.textStyles.seasonPickerInactive,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
