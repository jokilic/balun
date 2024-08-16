import 'package:flutter/material.dart';

import '../../../../../../models/squads/player/player.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'team_players_list_tile.dart';

class TeamPlayersContent extends StatelessWidget {
  final List<Player>? players;

  const TeamPlayersContent({
    required this.players,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: players?.length ?? 0,
        itemBuilder: (_, index) => TeamPlayersListTile(
          player: players![index],
        ),
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
