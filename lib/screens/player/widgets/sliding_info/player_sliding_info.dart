import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../constants.dart';
import '../../../../models/players/player_response.dart';
import '../../../../theme/theme.dart';
import '../../../../util/dependencies.dart';
import '../../controllers/player_season_controller.dart';
import '../../controllers/player_section_controller.dart';
import 'player_active_section.dart';
import 'player_section_titles.dart';

class PlayerSlidingInfo extends WatchingWidget {
  final PlayerResponse player;
  final ScrollController scrollController;

  const PlayerSlidingInfo({
    required this.player,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final playerSection = watchIt<PlayerSectionController>(
      instanceName: '${player.player?.id}',
    ).value;

    final playerSeason = watchIt<PlayerSeasonController>(
      instanceName: '${player.player?.id}',
    ).value;

    return ListView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      children: [
        ///
        /// BLACK LINE
        ///
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 176,
            vertical: 8,
          ),
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: context.colors.black.withOpacity(0.5),
          ),
        ),

        const SizedBox(height: 8),

        ///
        /// SECTIONS
        ///
        PlayerSectionTitles(
          activePlayerSection: playerSection,
          titlePressed: getIt
              .get<PlayerSectionController>(
                instanceName: '${player.player?.id}',
              )
              .updateState,
        ),

        const SizedBox(height: 24),

        ///
        /// ACTIVE SECTION
        ///
        Animate(
          key: ValueKey(playerSection),
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: BalunConstants.animationDuration,
            ),
          ],
          child: PlayerActiveSection(
            player: player,
            playerSection: playerSection,
            activeSeason: playerSeason,
          ),
        ),
      ],
    );
  }
}
