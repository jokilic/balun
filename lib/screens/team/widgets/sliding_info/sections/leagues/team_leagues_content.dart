import 'package:flutter/material.dart';

import '../../../../../../models/leagues/league_response.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'team_leagues_list_tile.dart';

class TeamLeaguesContent extends StatelessWidget {
  final List<LeagueResponse>? leagues;

  const TeamLeaguesContent({
    required this.leagues,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: leagues?.length ?? 0,
        itemBuilder: (_, index) => TeamLeaguesListTile(
          league: leagues![index],
        ),
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
