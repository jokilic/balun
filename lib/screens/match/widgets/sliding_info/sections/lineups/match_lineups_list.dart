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
  final int season;

  const MatchLineupsList({
    required this.homePlayers,
    required this.awayPlayers,
    required this.homePlayerColors,
    required this.awayPlayerColors,
    required this.season,
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
              season: season,
            ),
          ),

          ///
          /// AWAY
          ///
          Expanded(
            child: MatchLineupList(
              players: awayPlayers,
              colors: awayPlayerColors,
              season: season,
            ),
          ),
        ],
      );
}

class MatchLineupList extends StatelessWidget {
  final List<LineupPlayer>? players;
  final LineupColors? colors;
  final int season;

  const MatchLineupList({
    required this.players,
    required this.colors,
    required this.season,
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
            season: season,
          );
        },
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
