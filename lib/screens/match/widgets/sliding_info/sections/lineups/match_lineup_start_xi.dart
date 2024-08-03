import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/lineup/lineup.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/field_painter.dart';
import '../../../../../../util/lineups.dart';
import 'match_lineup_list.dart';
import 'match_lineups_player.dart';

class MatchLineupStartXI extends StatelessWidget {
  final Lineup? lineup;

  const MatchLineupStartXI({
    required this.lineup,
  });

  @override
  Widget build(BuildContext context) {
    if (lineup?.startXI?.isNotEmpty ?? false) {
      final formationLayers = parseFormation(lineup);
      final gridRows = formationLayers?.length;

      ///
      /// FIELD WITH PLAYERS
      ///
      if (formationLayers?.isNotEmpty ?? false) {
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
                    children: lineup!.startXI!
                        .map(
                          (player) => MatchLineupsPlayer(
                            player: player,
                            fieldHeight: fieldHeight,
                            fieldWidth: fieldWidth,
                            formationLayers: formationLayers,
                            totalRows: gridRows,
                            playerColors: lineup?.team?.colors,
                          ),
                        )
                        .toList(),
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
      return MatchLineupList(
        players: sortPlayersByPosition(
          lineup?.startXI,
        ),
        playerColors: lineup?.team?.colors,
      );
    }

    return const SizedBox.shrink();
  }
}
