import 'package:flutter/material.dart';

import '../../../../../../models/players/player_response.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'league_top_assists_list_tile.dart';

class LeagueTopAssistsContent extends StatelessWidget {
  final List<PlayerResponse>? assists;
  final int season;

  const LeagueTopAssistsContent({
    required this.assists,
    required this.season,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: assists?.length ?? 0,
        itemBuilder: (_, index) => LeagueTopAssistsListTile(
          assist: assists![index],
          season: season,
        ),
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
