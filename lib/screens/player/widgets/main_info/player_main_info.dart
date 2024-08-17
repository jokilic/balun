import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../constants.dart';
import '../../../../models/players/player_response.dart';
import '../../../../theme/icons.dart';
import '../../../../theme/theme.dart';
import '../../../../util/dependencies.dart';
import '../../../../util/team_seasons.dart';
import '../../../../widgets/balun_image.dart';
import '../../controllers/player_season_controller.dart';
import '../player_app_bar.dart';

class PlayerMainInfo extends WatchingWidget {
  final PlayerResponse player;

  const PlayerMainInfo({
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    final seasonState = watchIt<PlayerSeasonController>(
      instanceName: '${player.player?.id}',
    ).value;

    final years = generateYearList();

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
          PlayerAppBar(
            onPressed: Navigator.of(context).pop,
            player: player.player,
          ),

          const SizedBox(height: 48),

          ///
          /// LOGO
          ///
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BalunImage(
              imageUrl: player.player?.photo ?? BalunImages.placeholderLogo,
              height: 120,
              width: 120,
            ),
          ),

          const SizedBox(height: 16),

          ///
          /// NAME
          ///
          Text(
            player.player?.name ?? '---',
            style: context.textStyles.leagueName,
            textAlign: TextAlign.center,
          ),

          ///
          /// COUNTRY
          ///
          Text(
            player.player?.nationality ?? '---',
            style: context.textStyles.leagueCountry,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          ///
          /// SEASON
          ///
          Text(
            'Season',
            style: context.textStyles.leagueSeason,
            textAlign: TextAlign.center,
          ),
          DropdownButton<int>(
            onChanged: getIt
                .get<PlayerSeasonController>(
                  instanceName: '${player.player?.id}',
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
                BalunIcons.arrowDown,
                color: context.colors.black,
                height: 20,
                width: 20,
              ),
            ),
            items: years
                .map(
                  (year) => DropdownMenuItem(
                    value: year,
                    child: Text(
                      '$year',
                      style: context.textStyles.leagueSeasonDropdown,
                    ),
                  ),
                )
                .toList(),
            selectedItemBuilder: (context) => years
                .map(
                  (year) => Center(
                    child: Text(
                      '$year',
                      style: context.textStyles.leagueSeasonDropdown.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
