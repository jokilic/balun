import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/statistic/statistic_data.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/string.dart';

class MatchStatisticsListTile extends StatelessWidget {
  final StatisticData? homeStatisticData;
  final StatisticData? awayStatisticData;

  const MatchStatisticsListTile({
    this.homeStatisticData,
    this.awayStatisticData,
  });

  @override
  Widget build(BuildContext context) {
    final homeProgress = (homeStatisticData?.valueDouble ?? 0) / ((homeStatisticData?.valueDouble ?? 0) + (awayStatisticData?.valueDouble ?? 0));
    final awayProgress = (awayStatisticData?.valueDouble ?? 0) / ((homeStatisticData?.valueDouble ?? 0) + (awayStatisticData?.valueDouble ?? 0));

    final homeProgressColor = (homeStatisticData?.valueDouble ?? 0) > (awayStatisticData?.valueDouble ?? 0) ? context.colors.accent : context.colors.accent;
    final awayProgressColor = (awayStatisticData?.valueDouble ?? 0) > (homeStatisticData?.valueDouble ?? 0) ? context.colors.accent : context.colors.accent;

    return Column(
      children: [
        ///
        /// TEXT
        ///
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                '${homeStatisticData?.value ?? '-'}',
                style: context.textStyles.headlineLgBold,
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              flex: 4,
              child: Center(
                child: Text(
                  getStatisticText(
                    statisticData: homeStatisticData!,
                  ),
                  style: context.textStyles.titleMdMuted,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '${awayStatisticData?.value ?? '-'}',
                style: context.textStyles.headlineLgBold,
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        ///
        /// VISUAL INDICATOR
        ///
        Row(
          children: [
            Expanded(
              child: Transform.rotate(
                angle: pi,
                child: LinearProgressIndicator(
                  value: homeProgress.isNaN ? 0 : homeProgress,
                  backgroundColor: context.colors.primaryForeground.withValues(alpha: 0.15),
                  color: homeProgressColor,
                  borderRadius: BorderRadius.circular(100),
                  minHeight: 8,
                ),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: LinearProgressIndicator(
                value: awayProgress.isNaN ? 0 : awayProgress,
                backgroundColor: context.colors.primaryForeground.withValues(alpha: 0.15),
                color: awayProgressColor,
                borderRadius: BorderRadius.circular(100),
                minHeight: 8,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
