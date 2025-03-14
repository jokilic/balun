import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/players/player_response.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'league_top_yellow_cards_list_tile.dart';

class LeagueTopYellowCardsContent extends StatelessWidget {
  final List<PlayerResponse>? yellowCards;
  final String season;

  const LeagueTopYellowCardsContent({
    required this.yellowCards,
    required this.season,
  });

  @override
  Widget build(BuildContext context) => (yellowCards?.any(
            (player) =>
                player.statistics?.any(
                  (statistic) => (statistic.cards?.yellow ?? 0) > 0,
                ) ??
                false,
          ) ??
          false)
      ? ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: yellowCards?.length ?? 0,
          itemBuilder: (_, index) => LeagueTopYellowCardsListTile(
            yellowCard: yellowCards![index],
            season: season,
          ),
          separatorBuilder: (_, __) => const BalunSeperator(),
        )
      : BalunEmpty(
          message: 'leagueTopYellowCardsNo'.tr(),
          isSmall: true,
        );
}
