import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../constants.dart';
import '../../../../models/leagues/league_response.dart';
import '../../../../theme/icons.dart';
import '../../../../theme/theme.dart';
import '../../../../util/dependencies.dart';
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
              imageUrl: league.league?.logo ?? BalunImages.placeholderLogo,
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
          /// SEASON
          ///
          if (league.seasons?.isNotEmpty ?? false) ...[
            Text(
              'Season',
              style: context.textStyles.leagueSeason,
              textAlign: TextAlign.center,
            ),

            // TODO: Use `PageView` here
            DropdownButton<int>(
              onChanged: getIt
                  .get<LeagueSeasonController>(
                    instanceName: '${league.league?.id}',
                  )
                  .updateState,
              value: seasonState,
              borderRadius: BorderRadius.circular(8),
              dropdownColor: context.colors.white,
              style: context.textStyles.leagueSeasonDropdown,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              icon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Image.asset(
                  BalunIcons.ball,
                  color: context.colors.black,
                  height: 20,
                  width: 20,
                ),
              ),
              items: league.seasons!
                  .map(
                    (season) => DropdownMenuItem(
                      value: season.year,
                      child: Text(
                        '${season.year}',
                        style: context.textStyles.leagueSeasonDropdown,
                      ),
                    ),
                  )
                  .toList(),
              selectedItemBuilder: (context) => league.seasons!
                  .map(
                    (season) => Center(
                      child: Text(
                        '${season.year}',
                        style: context.textStyles.leagueSeasonDropdown.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
