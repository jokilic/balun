import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/lineup/lineup.dart';
import '../../../../../../models/fixtures/player_statistic/player_statistic.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/color.dart';
import '../../../../../../util/lineups.dart';
import '../../../../../../util/player_statistics.dart';
import '../../../../../../util/word_mix.dart';

class MatchLineupTeamData extends StatelessWidget {
  final bool matchLive;
  final Lineup? lineup;
  final PlayerStatistic? playerStatistic;

  const MatchLineupTeamData({
    required this.matchLive,
    required this.lineup,
    required this.playerStatistic,
  });

  @override
  Widget build(BuildContext context) {
    final averageRating = calculateAverageRating(
      playerStatistic: playerStatistic,
    );

    final playerPrimaryColor = textToColor(
      lineup?.team?.colors?.player?.primary,
    );
    final playerBorderColor = textToColor(
      lineup?.team?.colors?.player?.border,
    );
    final playerNumberColor = textToColor(
      lineup?.team?.colors?.player?.number,
    );

    return Column(
      children: [
        Row(
          children: [
            ///
            /// COLORS
            ///
            if (playerPrimaryColor != null) ...[
              Container(
                alignment: Alignment.center,
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: playerPrimaryColor,
                  border: Border.all(
                    color: playerBorderColor ?? playerPrimaryColor,
                    width: 2.5,
                  ),
                ),
                child: playerNumberColor != null
                    ? Text(
                        lineup?.team?.name?.substring(0, 1) ?? '',
                        style: context.textStyles.matchLineupsSectionNumber.copyWith(
                          color: playerNumberColor,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : null,
              ),
              const SizedBox(width: 14),
            ],

            ///
            /// NAME
            ///
            Expanded(
              child: Text(
                mixOrOriginalWords(lineup?.team?.name) ?? '---',
                style: context.textStyles.matchLineupsSectionTitle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///
            /// FORMATION
            ///
            if (lineup?.formation != null)
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'matchLineupFormation'.tr(),
                      style: context.textStyles.matchLineupsSectionText,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      lineup!.formation!,
                      style: context.textStyles.matchLineupsSectionSubtitle,
                    ),
                  ],
                ),
              ),

            ///
            /// RATING
            ///
            Expanded(
              child: Column(
                children: [
                  Text(
                    'matchLineupTeamRating'.tr(),
                    style: context.textStyles.matchLineupsSectionText,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: !matchLive && averageRating != null
                          ? getRatingColor(
                              averageRating,
                              context: context,
                            )
                          : context.colors.black.withValues(alpha: 0.5),
                      border: Border.all(
                        color: context.colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      !matchLive && averageRating != null ? averageRating.toStringAsFixed(1) : '---',
                      style: context.textStyles.matchLineupsSectionSubtitle.copyWith(
                        color: context.colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
