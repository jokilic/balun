import 'package:flutter/material.dart';

import '../../../../../../models/teams/team_response.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'league_teams_list_tile.dart';

class LeagueTeamsContent extends StatelessWidget {
  final List<TeamResponse> teams;
  final String season;

  const LeagueTeamsContent({
    required this.teams,
    required this.season,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: teams.length,
        itemBuilder: (_, index) => LeagueTeamsListTile(
          team: teams[index],
          season: season,
        ),
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
