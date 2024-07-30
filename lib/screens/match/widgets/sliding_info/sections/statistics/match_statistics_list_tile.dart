import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/statistic/statistic_data.dart';
import '../../../../../../util/string.dart';

class MatchStatisticsListTile extends StatelessWidget {
  final StatisticData? homeStatisticData;
  final StatisticData? awayStatisticData;

  const MatchStatisticsListTile({
    this.homeStatisticData,
    this.awayStatisticData,
  });

  @override
  Widget build(BuildContext context) => Text(
        getStatisticText(
          statisticData: homeStatisticData!,
        ),
      );
}
