import 'package:flutter/material.dart';

import '../../../../../../models/player_teams/player_team_response.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'player_teams_list_tile.dart';

class PlayerTeamsContent extends StatelessWidget {
  final List<PlayerTeamResponse>? teams;

  const PlayerTeamsContent({
    required this.teams,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: teams?.length ?? 0,
        itemBuilder: (_, index) => PlayerTeamsListTile(
          team: teams![index],
        ),
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
