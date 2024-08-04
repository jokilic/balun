import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/fixtures/player_statistic/player_statistic.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';
import 'match_player_statistic.dart';

class MatchPlayerStatisticsContent extends StatefulWidget {
  final PlayerStatistic? playerStatistic;

  const MatchPlayerStatisticsContent({
    required this.playerStatistic,
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
                          ? () => openTeam(
                                context,
                                teamId: widget.playerStatistic!.team!.id!,
                              )
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
                        widget.playerStatistic!.team!.name ?? '---',
                        style: context.textStyles.matchLineupsSectionTitle,
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: expanded ? 0 : 1,
                      duration: BalunConstants.animationDuration,
                      curve: Curves.easeIn,
                      child: Image.asset(
                        BalunIcons.playerOut,
                        height: 40,
                        width: 40,
                        color: context.colors.black.withOpacity(0.5),
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
              duration: BalunConstants.animationDuration,
              curve: Curves.easeIn,
              child: expanded
                  ? Column(
                      children: [
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Player statistics',
                            style: context.textStyles.matchLineupsSectionTitle,
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
