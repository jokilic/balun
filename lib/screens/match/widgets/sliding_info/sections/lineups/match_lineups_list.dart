import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/lineup/lineup_colors.dart';
import '../../../../../../models/fixtures/lineup/lineup_player.dart';
import '../../../../../../models/fixtures/player_statistic/player_statistic.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'match_lineup_list_tile.dart';

class MatchLineupsList extends StatelessWidget {
  final bool matchLive;
  final List<LineupPlayer>? homePlayers;
  final List<LineupPlayer>? awayPlayers;
  final PlayerStatistic? homePlayerStatistic;
  final PlayerStatistic? awayPlayerStatistic;
  final LineupColors? homePlayerColors;
  final LineupColors? awayPlayerColors;
  final String season;

  const MatchLineupsList({
    required this.matchLive,
    required this.homePlayers,
    required this.awayPlayers,
    required this.homePlayerStatistic,
    required this.awayPlayerStatistic,
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
              matchLive: matchLive,
              players: homePlayers,
              playerStatistic: homePlayerStatistic,
              colors: homePlayerColors,
              season: season,
            ),
          ),

          ///
          /// AWAY
          ///
          Expanded(
            child: MatchLineupList(
              matchLive: matchLive,
              players: awayPlayers,
              playerStatistic: awayPlayerStatistic,
              colors: awayPlayerColors,
              season: season,
            ),
          ),
        ],
      );
}

class MatchLineupList extends StatelessWidget {
  final bool matchLive;
  final List<LineupPlayer>? players;
  final PlayerStatistic? playerStatistic;
  final LineupColors? colors;
  final String season;

  const MatchLineupList({
    required this.matchLive,
    required this.players,
    required this.playerStatistic,
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
            matchLive: matchLive,
            player: player,
            playerStatistic: playerStatistic?.statistics
                ?.where(
                  (statisticData) => statisticData.player?.id == player?.id,
                )
                .firstOrNull,
            colors: colors,
            season: season,
          );
        },
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
