import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../models/players/player_response.dart';
import '../../../../theme/icons.dart';
import '../../../../theme/theme.dart';
import '../../../../util/custom_page_scroll_physics.dart';
import '../../../../util/dependencies.dart';
import '../../../../util/team_seasons.dart';
import '../../../../widgets/balun_button.dart';
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
          const SizedBox(height: 4),

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
              imageUrl: player.player?.photo ?? BalunIcons.placeholderPlayer,
              height: 120,
              width: 120,
            ),
          ),

          const SizedBox(height: 16),

          ///
          /// NAME
          ///
          Text(
            '${player.player?.firstName ?? '--'} ${player.player?.lastName ?? '--'}',
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
          /// SEASON TITLE
          ///
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
                  .get<PlayerSeasonController>(
                    instanceName: '${player.player?.id}',
                  )
                  .controller,
              physics: const CustomPageScrollPhysics(
                viewportFraction: 0.4,
              ),
              children: List.generate(
                years.length,
                (index) {
                  final year = years[index];

                  return BalunButton(
                    onPressed: () => getIt
                        .get<PlayerSeasonController>(
                          instanceName: '${player.player?.id}',
                        )
                        .updateState(year),
                    child: Center(
                      child: Text(
                        '$year',
                        style: seasonState == year ? context.textStyles.seasonPickerActive : context.textStyles.seasonPickerInactive,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
