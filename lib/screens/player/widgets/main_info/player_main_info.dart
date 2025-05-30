import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../models/players/player_response.dart';
import '../../../../routing.dart';
import '../../../../theme/icons.dart';
import '../../../../theme/theme.dart';
import '../../../../util/date_time.dart';
import '../../../../util/dependencies.dart';
import '../../../../util/scroll_configuration.dart';
import '../../../../util/string.dart';
import '../../../../util/team_seasons.dart';
import '../../../../util/word_mix.dart';
import '../../../../widgets/balun_button.dart';
import '../../../../widgets/balun_image/balun_image.dart';
import '../../controllers/player_current_team_controller.dart';
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
    final currentTeam = watchIt<PlayerCurrentTeamController>(
      instanceName: '${player.player?.id}',
    ).value;

    final pageController = getIt
        .get<PlayerSeasonController>(
          instanceName: '${player.player?.id}',
        )
        .controller;

    final years = generateYearList();

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
          PlayerAppBar(
            onPressed: Navigator.of(context).pop,
            player: player.player,
          ),

          const SizedBox(height: 48),

          ///
          /// PHOTO
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
            mixOrOriginalWords(player.player?.firstName) ?? '--',
            style: context.textStyles.leagueName,
            textAlign: TextAlign.center,
          ),
          Text(
            mixOrOriginalWords(player.player?.lastName) ?? '--',
            style: context.textStyles.leagueNameBold,
            textAlign: TextAlign.center,
          ),

          ///
          /// COUNTRY
          ///
          Text(
            player.player?.nationality != null
                ? mixOrOriginalWords(
                      getCountryName(
                        country: player.player!.nationality!,
                      ),
                    ) ??
                    '---'
                : '---',
            style: context.textStyles.leagueCountry,
            textAlign: TextAlign.center,
          ),

          ///
          /// TEAM
          ///
          if (currentTeam != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: BalunButton(
                onPressed: currentTeam.id != null
                    ? () => openTeam(
                          context,
                          teamId: currentTeam.id!,
                          season: player.statistics?.firstOrNull?.league?.season ?? getCurrentSeasonYear().toString(),
                        )
                    : null,
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BalunImage(
                        imageUrl: currentTeam.logo ?? BalunIcons.placeholderTeam,
                        height: 32,
                        width: 32,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          mixOrOriginalWords(currentTeam.name) ?? '---',
                          style: context.textStyles.fixturesLeague,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          const SizedBox(height: 16),

          ///
          /// SEASON TITLE
          ///
          Text(
            'playerInfoSeason'.tr(),
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
                  years.length,
                  (index) {
                    final year = years[index];

                    return BalunButton(
                      onPressed: () => getIt
                          .get<PlayerSeasonController>(
                            instanceName: '${player.player?.id}',
                          )
                          .updateState(year.toString()),
                      child: Center(
                        child: Text(
                          '$year',
                          style: seasonState == year.toString() ? context.textStyles.seasonPickerActive : context.textStyles.seasonPickerInactive,
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
      ),
    );
  }
}
