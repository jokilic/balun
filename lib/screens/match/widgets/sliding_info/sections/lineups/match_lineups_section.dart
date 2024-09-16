import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/lineup/lineup.dart';
import '../../../../../../models/fixtures/player_statistic/player_statistic.dart';
import '../../../../../../widgets/balun_empty.dart';
import 'match_lineup_content.dart';

class MatchLineupsSection extends StatelessWidget {
  final Lineup? homeLineup;
  final Lineup? awayLineup;
  final PlayerStatistic? homePlayerStatistic;
  final PlayerStatistic? awayPlayerStatistic;
  final int? matchElapsed;
  final int season;

  const MatchLineupsSection({
    required this.homeLineup,
    required this.awayLineup,
    required this.homePlayerStatistic,
    required this.awayPlayerStatistic,
    required this.matchElapsed,
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
            /// NO LINEUPS
            ///
            if (homeLineup == null && awayLineup == null)
              BalunEmpty(
                message: 'matchLineupNo'.tr(),
                isSmall: true,
              )

            ///
            /// FIELD
            ///
            else
              MatchLineupContent(
                homeLineup: homeLineup,
                awayLineup: awayLineup,
                homePlayerStatistic: homePlayerStatistic,
                awayPlayerStatistic: awayPlayerStatistic,
                matchElapsed: matchElapsed,
                season: season,
              ),

            const SizedBox(height: 24),
          ],
        ),
      );
}
