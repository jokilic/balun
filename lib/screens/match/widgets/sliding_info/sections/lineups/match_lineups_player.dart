import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/lineup/lineup_player.dart';

class MatchLineupsPlayer extends StatelessWidget {
  final LineupPlayer? player;
  final double? cellWidth;
  final double? cellHeight;
  final List<int>? formationLayers;
  final int? gridColumns;

  const MatchLineupsPlayer({
    required this.player,
    required this.cellWidth,
    required this.cellHeight,
    required this.formationLayers,
    required this.gridColumns,
  });

  @override
  Widget build(BuildContext context) {
    final gridParts = player?.player?.grid?.split(':');
    final row = int.parse(gridParts![0]);
    final positionInRow = int.parse(gridParts[1]);

    /// Calculate x position
    final playersInRow = formationLayers![row - 1];
    final spacing = gridColumns! / (playersInRow + 1);
    final x = spacing * positionInRow;

    return Positioned(
      left: (x - 0.5) * cellWidth!,
      top: (row - 0.5) * cellHeight!,
      child: Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            player?.player?.pos ?? '---',
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
        ),
      ),
    );
  }
}
