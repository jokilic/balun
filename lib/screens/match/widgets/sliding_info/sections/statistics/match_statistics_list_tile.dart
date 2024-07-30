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
    final homeValue = double.tryParse(
          '${homeStatisticData?.value}'.replaceAll('%', ''),
        ) ??
        0;

    final awayValue = double.tryParse(
          '${awayStatisticData?.value}'.replaceAll('%', ''),
        ) ??
        0;

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
                style: context.textStyles.matchStatisticsSectionNumber,
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
                  style: context.textStyles.matchStatisticsSectionText,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '${awayStatisticData?.value ?? '-'}',
                style: context.textStyles.matchStatisticsSectionNumber,
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
                  value: homeValue == 0 && awayValue == 0 ? 0 : homeValue / (homeValue + awayValue),
                  backgroundColor: context.colors.black.withOpacity(0.15),
                  color: homeValue > awayValue ? context.colors.green : context.colors.greenish,
                  borderRadius: BorderRadius.circular(100),
                  minHeight: 8,
                ),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: LinearProgressIndicator(
                value: homeValue == 0 && awayValue == 0 ? 0 : awayValue / (homeValue + awayValue),
                backgroundColor: context.colors.black.withOpacity(0.15),
                color: awayValue > homeValue ? context.colors.green : context.colors.greenish,
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
