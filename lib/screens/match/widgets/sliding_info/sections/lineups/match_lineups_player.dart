import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/lineup/lineup_colors.dart';
import '../../../../../../models/fixtures/lineup/lineup_player.dart';
import '../../../../../../models/fixtures/player_statistic/player_statistic_data.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/color.dart';
import '../../../../../../util/lineups.dart';
import '../../../../../../util/player_statistics.dart';
import '../../../../../../util/string.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image/balun_image.dart';

class MatchLineupsPlayer extends StatelessWidget {
  final bool matchLive;
  final LineupPlayer? player;
  final PlayerStatisticData? playerStatistic;
  final int? matchElapsed;
  final double? fieldHeight;
  final double? fieldWidth;
  final List<int>? formation;
  final LineupColors? playerColors;
  final bool isHome;
  final String season;

  const MatchLineupsPlayer({
    required this.matchLive,
    required this.player,
    required this.playerStatistic,
    required this.matchElapsed,
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

      final playerPrimaryColor =
          textToColor(
            player?.player?.pos == 'G' ? playerColors?.goalkeeper?.primary : playerColors?.player?.primary,
          ) ??
          context.colors.primaryBackground;

      final playerBorderColor =
          textToColor(
            player?.player?.pos == 'G' ? playerColors?.goalkeeper?.border : playerColors?.player?.border,
          ) ??
          context.colors.primaryBackground;

      final playerNumberColor =
          textToColor(
            player?.player?.pos == 'G' ? playerColors?.goalkeeper?.number : playerColors?.player?.number,
          ) ??
          context.colors.primaryForeground;

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
      final minutesPlayed = playerStatistic?.statistic?.fold(
        0,
        (sum, statistic) => sum + (statistic.games?.minutes ?? 0),
      );
      final rating = playerStatistic?.statistic?.firstOrNull?.games?.rating;

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
              if (player?.player?.name != null)
                Positioned(
                  bottom: -16,
                  child: Text(
                    mixOrOriginalWords(getLastWord(player!.player!.name!)) ?? '---',
                    style: context.textStyles.matchLineupsSectionPlayer,
                    textAlign: TextAlign.center,
                  ),
                ),

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
                    color: context.colors.primaryBackground,
                  ),
                ),

              ///
              /// RED CARDS
              ///
              if ((redCards ?? 0) > 0 && (yellowCards ?? 9) <= 1)
                const Positioned(
                  right: -8,
                  top: -4,
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
                  top: -4,
                  child: BalunImage(
                    imageUrl: yellowCards == 1 ? BalunIcons.yellowCard : BalunIcons.cards,
                    height: 20,
                    width: 20,
                  ),
                ),

              if (!matchLive) ...[
                ///
                /// SUBSTITUTION
                ///
                if ((minutesPlayed ?? 0) < (matchElapsed ?? 0) && (yellowCards ?? 0) < 2 && (redCards ?? 0) < 1)
                  Positioned(
                    right: -10,
                    bottom: -6,
                    child: BalunImage(
                      imageUrl: BalunIcons.playerOut,
                      color: context.colors.danger,
                      height: 24,
                      width: 24,
                    ),
                  ),

                ///
                /// RATING
                ///
                if (rating != null)
                  Positioned(
                    left: -20,
                    bottom: -6,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: getRatingColor(
                          rating,
                          context: context,
                        ),
                        border: Border.all(
                          color: context.colors.primaryForeground,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        rating.toStringAsFixed(1),
                        style: context.textStyles.matchLineupRating,
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
