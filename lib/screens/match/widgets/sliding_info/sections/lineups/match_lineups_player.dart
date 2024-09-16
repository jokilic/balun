import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/lineup/lineup_colors.dart';
import '../../../../../../models/fixtures/lineup/lineup_player.dart';
import '../../../../../../models/fixtures/player_statistic/player_statistic_data.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/color.dart';
import '../../../../../../util/lineups.dart';
import '../../../../../../util/string.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';

class MatchLineupsPlayer extends StatelessWidget {
  final LineupPlayer? player;
  final PlayerStatisticData? playerStatistic;
  final double? fieldHeight;
  final double? fieldWidth;
  final List<int>? formation;
  final LineupColors? playerColors;
  final bool isHome;
  final int season;

  const MatchLineupsPlayer({
    required this.player,
    required this.playerStatistic,
    required this.fieldHeight,
    required this.fieldWidth,
    required this.formation,
    required this.playerColors,
    required this.isHome,
    required this.season,
  });

  @override
  Widget build(BuildContext context) {
    if (player?.player != null && fieldHeight != null && fieldWidth != null && (formation?.isNotEmpty ?? false)) {
      final gridParts = player!.player!.grid!.split(':');
      final row = int.parse(gridParts[0]);
      final positionInRow = int.parse(gridParts[1]);

      /// Calculate y position with enhanced spacing
      final rowSpacings = calculateRowSpacings(
        formation?.length ?? 0,
        isHome,
      );
      final yPosition = calculateYPosition(
        row,
        rowSpacings,
        isHome,
      );

      /// Calculate x position with enhanced spacing
      final playersInRow = formation![row - 1];
      final xPosition = calculateXPosition(
        positionInRow,
        playersInRow,
      );

      /// Adjust positions based on whether it's home or away team
      final adjustedYPosition = isHome ? yPosition / 2 : 0.5 + yPosition / 2;
      final adjustedXPosition = isHome ? xPosition : 1 - xPosition;

      /// Set player sizes & colors
      const playerSize = 32.0;

      final playerPrimaryColor = textToColor(
            player?.player?.pos == 'G' ? playerColors?.goalkeeper?.primary : playerColors?.player?.primary,
          ) ??
          context.colors.white;

      final playerBorderColor = textToColor(
            player?.player?.pos == 'G' ? playerColors?.goalkeeper?.border : playerColors?.player?.border,
          ) ??
          context.colors.white;

      final playerNumberColor = textToColor(
            player?.player?.pos == 'G' ? playerColors?.goalkeeper?.number : playerColors?.player?.number,
          ) ??
          context.colors.black;

      final goals = playerStatistic?.statistic?.fold(
        0,
        (sum, statistic) => sum + (statistic.goals?.total ?? 0),
      );
      final yellowCards = playerStatistic?.statistic?.fold(
        0,
        (sum, statistic) => sum + (statistic.cards?.yellow ?? 0),
      );
      final redCards = playerStatistic?.statistic?.fold(
        0,
        (sum, statistic) => sum + (statistic.cards?.red ?? 0),
      );

      return Positioned(
        left: adjustedXPosition * fieldWidth! - playerSize / 2,
        top: adjustedYPosition * fieldHeight! - playerSize / 2,
        child: BalunButton(
          onPressed: player?.player?.id != null
              ? () => openPlayer(
                    context,
                    playerId: player!.player!.id!,
                    season: season,
                  )
              : null,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              ///
              /// CIRCLE WITH NUMBER
              ///
              Container(
                alignment: Alignment.center,
                height: playerSize,
                width: playerSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: playerPrimaryColor,
                  border: Border.all(
                    color: playerBorderColor,
                    width: 2.5,
                  ),
                ),
                child: Text(
                  '${player?.player?.number ?? '--'}',
                  style: context.textStyles.matchLineupsSectionNumber.copyWith(
                    color: playerNumberColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              ///
              /// NAME
              ///
              if (player?.player?.name != null) ...[
                Positioned(
                  bottom: -16,
                  child: Text(
                    getLastWord(player!.player!.name!),
                    style: context.textStyles.matchLineupsSectionPlayer,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],

              ///
              /// GOALS
              ///
              if ((goals ?? 0) > 0)
                Positioned(
                  left: -8,
                  top: -6,
                  child: BalunImage(
                    imageUrl: BalunIcons.ball,
                    height: 20,
                    width: 20,
                    color: context.colors.white,
                  ),
                ),

              ///
              /// RED CARDS
              ///
              if ((redCards ?? 0) > 0 && (yellowCards ?? 9) <= 1)
                const Positioned(
                  right: -8,
                  top: -2,
                  child: BalunImage(
                    imageUrl: BalunIcons.redCard,
                    height: 20,
                    width: 20,
                  ),
                ),

              ///
              /// YELLOW CARDS
              ///
              if ((yellowCards ?? 0) > 0)
                Positioned(
                  right: -8,
                  top: -2,
                  child: BalunImage(
                    imageUrl: yellowCards == 1 ? BalunIcons.yellowCard : BalunIcons.cards,
                    height: 20,
                    width: 20,
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
