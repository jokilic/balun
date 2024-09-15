import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/players/player_response.dart';
import '../../../../../../widgets/balun_empty.dart';
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
  Widget build(BuildContext context) => (assists?.any(
            (player) =>
                player.statistics?.any(
                  (statistic) => (statistic.goals?.assists ?? 0) > 0,
                ) ??
                false,
          ) ??
          false)
      ? ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: assists?.length ?? 0,
          itemBuilder: (_, index) => LeagueTopAssistsListTile(
            assist: assists![index],
            season: season,
          ),
          separatorBuilder: (_, __) => const BalunSeperator(),
        )
      : BalunEmpty(
          message: 'leagueTopAssistsNo'.tr(),
          isSmall: true,
        );
}
