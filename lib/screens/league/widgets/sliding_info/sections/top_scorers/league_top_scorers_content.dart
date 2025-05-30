import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/players/player_response.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'league_top_scorers_list_tile.dart';

class LeagueTopScorersContent extends StatelessWidget {
  final List<PlayerResponse>? scorers;
  final String season;

  const LeagueTopScorersContent({
    required this.scorers,
    required this.season,
  });

  @override
  Widget build(BuildContext context) => (scorers?.any(
            (player) =>
                player.statistics?.any(
                  (statistic) => (statistic.goals?.total ?? 0) > 0,
                ) ??
                false,
          ) ??
          false)
      ? ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: scorers?.length ?? 0,
          itemBuilder: (_, index) => LeagueTopScorersListTile(
            scorer: scorers![index],
            season: season,
          ),
          separatorBuilder: (_, __) => const BalunSeperator(),
        )
      : BalunEmpty(
          message: 'leagueTopScorersNo'.tr(),
          isSmall: true,
        );
}
