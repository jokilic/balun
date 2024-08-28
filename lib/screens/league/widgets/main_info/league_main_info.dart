import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../constants.dart';
import '../../../../models/leagues/league_response.dart';
import '../../../../theme/theme.dart';
import '../../../../util/custom_page_scroll_physics.dart';
import '../../../../util/dependencies.dart';
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

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ///
          /// BACK & LEAGUE
          ///
          LeagueAppBar(
            onPressed: Navigator.of(context).pop,
            league: league.league!,
          ),

          const SizedBox(height: 48),

          ///
          /// LOGO
          ///
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BalunImage(
              imageUrl: league.league?.logo ?? BalunImages.placeholderIcon,
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
            league.country?.name ?? '---',
            style: context.textStyles.leagueCountry,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          ///
          /// SEASON TITLE
          ///
          if (league.seasons?.isNotEmpty ?? false) ...[
            Text(
              'Season',
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
                physics: const CustomPageScrollPhysics(
                  viewportFraction: 0.4,
                ),
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
