import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/player_statistic/player_statistic.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_empty.dart';
import 'match_player_statistics_content.dart';

class MatchPlayerStatisticsSection extends StatelessWidget {
  final PlayerStatistic? homePlayerStatistic;
  final PlayerStatistic? awayPlayerStatistic;
  final int season;

  const MatchPlayerStatisticsSection({
    required this.homePlayerStatistic,
    required this.awayPlayerStatistic,
    required this.season,
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
            /// NO STATISTICS
            ///
            if (homePlayerStatistic == null && awayPlayerStatistic == null)
              BalunEmpty(
                message: 'matchPlayerStatisticsNo'.tr(),
                isSmall: true,
              )
            else ...[
              ///
              /// HOME
              ///
              if (homePlayerStatistic != null)
                MatchPlayerStatisticsContent(
                  playerStatistic: homePlayerStatistic,
                  season: season,
                ),

              ///
              /// DIVIDER
              ///
              if (homePlayerStatistic != null && awayPlayerStatistic != null)
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 80,
                    vertical: 20,
                  ),
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: context.colors.black.withOpacity(0.25),
                  ),
                ),

              ///
              /// HOME
              ///
              if (awayPlayerStatistic != null)
                MatchPlayerStatisticsContent(
                  playerStatistic: awayPlayerStatistic,
                  season: season,
                ),
            ],

            const SizedBox(height: 24),
          ],
        ),
      );
}
