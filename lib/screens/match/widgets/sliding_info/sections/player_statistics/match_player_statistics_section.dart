import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/player_statistic/player_statistic.dart';
import '../../../../../../theme/theme.dart';
import 'match_player_statistics_content.dart';

class MatchPlayerStatisticsSection extends StatelessWidget {
  final PlayerStatistic? homePlayerStatistic;
  final PlayerStatistic? awayPlayerStatistic;

  const MatchPlayerStatisticsSection({
    required this.homePlayerStatistic,
    required this.awayPlayerStatistic,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          children: [
            ///
            /// HOME
            ///
            MatchPlayerStatisticsContent(
              playerStatistic: homePlayerStatistic,
            ),

            ///
            /// DIVIDER
            ///
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 80,
                vertical: 20,
              ),
              height: 4,
              color: context.colors.greenish,
            ),

            ///
            /// HOME
            ///
            MatchPlayerStatisticsContent(
              playerStatistic: awayPlayerStatistic,
            ),
          ],
        ),
      );
}