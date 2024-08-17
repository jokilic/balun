import 'package:flutter/material.dart';

import '../../../../../../models/players/player_response.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'league_top_red_cards_list_tile.dart';

class LeagueTopRedCardsContent extends StatelessWidget {
  final List<PlayerResponse>? redCards;
  final int season;

  const LeagueTopRedCardsContent({
    required this.redCards,
    required this.season,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: redCards?.length ?? 0,
        itemBuilder: (_, index) => LeagueTopRedCardsListTile(
          redCard: redCards![index],
          season: season,
        ),
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
