import 'package:flutter/material.dart';

import '../../../../../../models/players/player_response.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'league_top_scorers_list_tile.dart';

class LeagueTopScorersContent extends StatelessWidget {
  final List<PlayerResponse>? scorers;
  final int season;

  const LeagueTopScorersContent({
    required this.scorers,
    required this.season,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: scorers?.length ?? 0,
        itemBuilder: (_, index) => LeagueTopScorersListTile(
          scorer: scorers![index],
          season: season,
        ),
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
