import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/fixtures/player_statistic/player_statistic.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';
import 'match_player_statistic.dart';

class MatchPlayerStatisticsContent extends StatefulWidget {
  final PlayerStatistic? playerStatistic;
  final String season;

  const MatchPlayerStatisticsContent({
    required this.playerStatistic,
    required this.season,
  });

  @override
  State<MatchPlayerStatisticsContent> createState() => _MatchPlayerStatisticsContentState();
}

class _MatchPlayerStatisticsContentState extends State<MatchPlayerStatisticsContent> {
  var expanded = false;

  void toggleExpanded() => setState(
    () => expanded = !expanded,
  );

  @override
  Widget build(BuildContext context) => Column(
    children: [
      ///
      /// INFO
      ///
      if (widget.playerStatistic?.team != null) ...[
        BalunButton(
          onPressed: toggleExpanded,
          child: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                BalunButton(
                  onPressed: widget.playerStatistic?.team?.id != null
                      ? () {
                          HapticFeedback.lightImpact();
                          openTeam(
                            context,
                            teamId: widget.playerStatistic!.team!.id!,
                            season: widget.season,
                          );
                        }
                      : null,
                  child: BalunImage(
                    imageUrl: widget.playerStatistic!.team!.logo!,
                    height: 64,
                    width: 64,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    mixOrOriginalWords(widget.playerStatistic!.team!.name ?? '---') ?? '---',
                    style: context.textStyles.headlineMdBold,
                  ),
                ),
                AnimatedOpacity(
                  opacity: expanded ? 0 : 1,
                  duration: BalunConstants.animationDuration,
                  curve: Curves.easeIn,
                  child: BalunImage(
                    imageUrl: BalunIcons.playerOut,
                    height: 40,
                    width: 40,
                    color: context.colors.primaryForeground.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
      ],

      ///
      /// STATISTICS
      ///
      if (widget.playerStatistic?.statistics?.isNotEmpty ?? false) ...[
        AnimatedSize(
          duration: BalunConstants.expandDuration,
          curve: Curves.easeIn,
          child: expanded
              ? Column(
                  children: [
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'matchPlayerStatistics'.tr(),
                        style: context.textStyles.headlineMdBold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    MatchPlayerStatistic(
                      statistics: widget.playerStatistic?.statistics,
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    ],
  );
}
