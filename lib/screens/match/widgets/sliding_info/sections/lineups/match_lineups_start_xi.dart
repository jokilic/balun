import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/lineup/lineup.dart';
import '../../../../../../models/fixtures/player_statistic/player_statistic.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/field_painter.dart';
import '../../../../../../util/lineups.dart';
import 'match_lineups_list.dart';
import 'match_lineups_player.dart';

class MatchLineupsStartXI extends StatelessWidget {
  final bool matchLive;
  final Lineup? homeLineup;
  final Lineup? awayLineup;
  final PlayerStatistic? homePlayerStatistic;
  final PlayerStatistic? awayPlayerStatistic;
  final int? matchElapsed;
  final String season;

  const MatchLineupsStartXI({
    required this.matchLive,
    required this.homeLineup,
    required this.awayLineup,
    required this.homePlayerStatistic,
    required this.awayPlayerStatistic,
    required this.matchElapsed,
    required this.season,
  });

  @override
  Widget build(BuildContext context) {
    if (homeLineup != null && awayLineup != null) {
      final homeFormation = parseFormation(homeLineup);
      final awayFormation = parseFormation(awayLineup);

      return AspectRatio(
        aspectRatio: 0.55,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final fieldWidth = constraints.maxWidth;
            final fieldHeight = constraints.maxHeight;

            return Container(
              height: fieldHeight,
              width: fieldWidth,
              decoration: BoxDecoration(
                color: context.colors.green,
                border: Border.all(
                  color: context.colors.green,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomPaint(
                painter: FieldPainter(
                  linesColor: context.colors.white.withValues(alpha: 0.4),
                ),
                child: Stack(
                  children: [
                    ///
                    /// HOME
                    ///
                    if (homeLineup?.startXI?.isNotEmpty ?? false)
                      ...homeLineup!.startXI!
                          .map(
                            (player) => MatchLineupsPlayer(
                              matchLive: matchLive,
                              player: player,
                              playerStatistic: homePlayerStatistic?.statistics
                                  ?.where(
                                    (statisticData) => statisticData.player?.id == player.player?.id,
                                  )
                                  .firstOrNull,
                              matchElapsed: matchElapsed,
                              fieldHeight: fieldHeight,
                              fieldWidth: fieldWidth,
                              formation: homeFormation,
                              playerColors: homeLineup?.team?.colors,
                              isHome: true,
                              season: season,
                            ),
                          )
                          .toList(),

                    ///
                    /// AWAY
                    ///
                    if (awayLineup?.startXI?.isNotEmpty ?? false)
                      ...awayLineup!.startXI!
                          .map(
                            (player) => MatchLineupsPlayer(
                              matchLive: matchLive,
                              player: player,
                              playerStatistic: awayPlayerStatistic?.statistics
                                  ?.where(
                                    (statisticData) => statisticData.player?.id == player.player?.id,
                                  )
                                  .firstOrNull,
                              matchElapsed: matchElapsed,
                              fieldHeight: fieldHeight,
                              fieldWidth: fieldWidth,
                              formation: awayFormation,
                              playerColors: awayLineup?.team?.colors,
                              isHome: false,
                              season: season,
                            ),
                          )
                          .toList(),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    ///
    /// LIST OF PLAYERS
    ///
    return MatchLineupsList(
      matchLive: matchLive,
      homePlayers: sortPlayersByPosition(
        homeLineup?.startXI,
      ),
      awayPlayers: sortPlayersByPosition(
        awayLineup?.startXI,
      ),
      homePlayerStatistic: homePlayerStatistic,
      awayPlayerStatistic: awayPlayerStatistic,
      homePlayerColors: homeLineup?.team?.colors,
      awayPlayerColors: awayLineup?.team?.colors,
      season: season,
    );
  }
}
