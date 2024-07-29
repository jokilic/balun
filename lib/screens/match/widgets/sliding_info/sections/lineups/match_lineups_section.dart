import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/lineup/lineup.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/field_painter.dart';
import 'match_lineups_player.dart';

class MatchLineupsSection extends StatelessWidget {
  final List<Lineup>? lineups;

  const MatchLineupsSection({
    required this.lineups,
  });

  List<int>? parseFormation() {
    final lineup = lineups?.first;

    if (lineup?.formation != null) {
      return [1] + lineup!.formation!.split('-').map(int.parse).toList();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final formationLayers = parseFormation();

    final gridRows = formationLayers?.length ?? 0;
    final gridColumns = formationLayers?.reduce((a, b) => a > b ? a : b) ?? 0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final fieldWidth = constraints.maxWidth;
        final fieldHeight = constraints.maxHeight;

        final cellWidth = fieldWidth / gridColumns;
        final cellHeight = fieldHeight / gridRows;

        return AspectRatio(
          aspectRatio: 68 / 105,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green[800],
              border: Border.all(
                color: context.colors.white,
                width: 2,
              ),
            ),
            child: CustomPaint(
              painter: FieldPainter(),
              child: Stack(
                children: lineups!.first.startXI!
                    .map(
                      (player) => MatchLineupsPlayer(
                        player: player,
                        cellWidth: cellWidth,
                        cellHeight: cellHeight,
                        formationLayers: formationLayers,
                        gridColumns: gridColumns,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
