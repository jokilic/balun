import 'package:flutter/material.dart';

import '../../../../../../models/squads/player/player.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'team_players_list_tile.dart';

class TeamPlayersContent extends StatelessWidget {
  final List<Player>? players;
  final String season;

  const TeamPlayersContent({
    required this.players,
    required this.season,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: players?.length ?? 0,
        itemBuilder: (_, index) => TeamPlayersListTile(
          player: players![index],
          season: season,
        ),
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
