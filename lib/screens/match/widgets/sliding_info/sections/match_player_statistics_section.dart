import 'package:flutter/material.dart';

import '../../../../../models/fixtures/player_statistic/player_statistic.dart';

class MatchPlayerStatisticsSection extends StatelessWidget {
  final PlayerStatistic? homePlayerStatistic;
  final PlayerStatistic? awayPlayerStatistic;

  const MatchPlayerStatisticsSection({
    required this.homePlayerStatistic,
    required this.awayPlayerStatistic,
  });
  @override
  Widget build(BuildContext context) => Text(
        '${homePlayerStatistic?.statistics?.first.statistic?.first.passes?.total}',
      );
}
