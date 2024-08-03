import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/lineup/lineup_colors.dart';
import '../../../../../../models/fixtures/lineup/lineup_player.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'match_lineup_list_tile.dart';

class MatchLineupsList extends StatelessWidget {
  final List<LineupPlayer>? homePlayers;
  final List<LineupPlayer>? awayPlayers;
  final LineupColors? homePlayerColors;
  final LineupColors? awayPlayerColors;

  const MatchLineupsList({
    required this.homePlayers,
    required this.awayPlayers,
    required this.homePlayerColors,
    required this.awayPlayerColors,
  });

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///
          /// HOME
          ///
          Expanded(
            child: MatchLineupList(
              players: homePlayers,
              colors: homePlayerColors,
            ),
          ),

          ///
          /// AWAY
          ///
          Expanded(
            child: MatchLineupList(
              players: awayPlayers,
              colors: awayPlayerColors,
            ),
          ),
        ],
      );
}

class MatchLineupList extends StatelessWidget {
  final List<LineupPlayer>? players;
  final LineupColors? colors;

  const MatchLineupList({
    required this.players,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: players?.length ?? 0,
        itemBuilder: (context, index) {
          final player = players![index].player;

          return MatchLineupListTile(
            player: player,
            colors: colors,
          );
        },
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
