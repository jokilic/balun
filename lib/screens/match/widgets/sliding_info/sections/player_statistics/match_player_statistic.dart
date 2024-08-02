import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/player_statistic/player_statistic_data.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'match_player_list_tile.dart';

class MatchPlayerStatistic extends StatelessWidget {
  final List<PlayerStatisticData>? statistics;

  const MatchPlayerStatistic({
    required this.statistics,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: statistics?.length ?? 0,
        itemBuilder: (context, index) => MatchPlayerListTile(
          statisticData: statistics![index],
        ),
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
