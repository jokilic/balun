import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/lineup/lineup.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/field_painter.dart';
import '../../../../../../util/lineups.dart';
import 'match_lineups_list.dart';
import 'match_lineups_player.dart';

class MatchLineupsStartXI extends StatelessWidget {
  final Lineup? homeLineup;
  final Lineup? awayLineup;

  const MatchLineupsStartXI({
    required this.homeLineup,
    required this.awayLineup,
  });

  @override
  Widget build(BuildContext context) {
    if (homeLineup != null && awayLineup != null) {
      final homeFormation = parseFormation(homeLineup);
      final awayFormation = parseFormation(awayLineup);

      return AspectRatio(
        aspectRatio: 68 / 105,
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
                  linesColor: context.colors.white.withOpacity(0.4),
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
                              player: player,
                              fieldHeight: fieldHeight,
                              fieldWidth: fieldWidth,
                              formation: homeFormation,
                              playerColors: homeLineup?.team?.colors,
                              isHome: true,
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
                              player: player,
                              fieldHeight: fieldHeight,
                              fieldWidth: fieldWidth,
                              formation: awayFormation,
                              playerColors: awayLineup?.team?.colors,
                              isHome: false,
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
      homePlayers: sortPlayersByPosition(
        homeLineup?.startXI,
      ),
      awayPlayers: sortPlayersByPosition(
        awayLineup?.startXI,
      ),
      homePlayerColors: homeLineup?.team?.colors,
      awayPlayerColors: awayLineup?.team?.colors,
    );
  }
}
