import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/statistic/statistic.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'match_statistics_list_tile.dart';

class MatchStatisticsSection extends StatelessWidget {
  final Statistic? homeStatistic;
  final Statistic? awayStatistic;

  const MatchStatisticsSection({
    required this.homeStatistic,
    required this.awayStatistic,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: homeStatistic?.statistics?.length ?? awayStatistic?.statistics?.length ?? 0,
        itemBuilder: (_, index) {
          final homeStatisticData = homeStatistic!.statistics![index];
          final awayStatisticData = awayStatistic!.statistics![index];

          return MatchStatisticsListTile(
            homeStatisticData: homeStatisticData,
            awayStatisticData: awayStatisticData,
          );
        },
        separatorBuilder: (_, __) => BalunSeperator(),
      );
}
