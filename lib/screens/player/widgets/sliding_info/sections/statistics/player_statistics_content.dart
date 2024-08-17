import 'package:flutter/material.dart';

import '../../../../../../models/players/statistic/statistic.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'player_statistics_list_tile.dart';

class PlayerStatisticsContent extends StatelessWidget {
  final List<Statistic>? statistics;
  final int season;

  const PlayerStatisticsContent({
    required this.statistics,
    required this.season,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: statistics?.length ?? 0,
        itemBuilder: (_, index) => PlayerStatisticsListTile(
          statistic: statistics![index],
          season: season,
        ),
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
