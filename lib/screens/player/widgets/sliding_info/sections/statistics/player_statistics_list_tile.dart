import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/players/statistic/statistic.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/string.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';
import 'player_statistics_list_tile_value.dart';

class PlayerStatisticsListTile extends StatefulWidget {
  final Statistic? statistic;
  final String season;

  const PlayerStatisticsListTile({
    required this.statistic,
    required this.season,
  });

  @override
  State<PlayerStatisticsListTile> createState() => _PlayerStatisticsListTileState();
}

class _PlayerStatisticsListTileState extends State<PlayerStatisticsListTile> {
  var expanded = false;

  void toggleExpanded() => setState(
        () => expanded = !expanded,
      );

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            ///
            /// NAME
            ///
            if (widget.statistic?.team != null)
              BalunButton(
                onPressed: toggleExpanded,
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///
                      /// LOGO
                      ///
                      BalunImage(
                        imageUrl: widget.statistic?.team?.logo ?? BalunIcons.placeholderTeam,
                        height: 56,
                        width: 56,
                      ),
                      const SizedBox(width: 12),

                      ///
                      /// NAME
                      ///
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.statistic?.team?.name ?? '--',
                              style: context.textStyles.matchPlayerStatisticsName,
                            ),
                            Text(
                              widget.statistic?.league?.name ?? '--',
                              style: context.textStyles.matchPlayerStatisticsText,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ///
            /// STATISTICS
            ///
            AnimatedSize(
              duration: BalunConstants.animationDuration,
              curve: Curves.easeIn,
              child: expanded
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///
                                /// GAMES
                                ///
                                Text(
                                  'playerStatisticsGames'.tr(),
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsAppearences'.tr(),
                                  text: '${widget.statistic?.games?.appearences ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsLineups'.tr(),
                                  text: '${widget.statistic?.games?.lineups ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsMinutes'.tr(),
                                  text: widget.statistic?.games?.minutes != null ? "${widget.statistic?.games?.minutes}'" : '--',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsNumber'.tr(),
                                  text: '${widget.statistic?.games?.number ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsPosition'.tr(),
                                  text: widget.statistic?.games?.position != null
                                      ? getPositionText(
                                          position: widget.statistic!.games!.position!,
                                        )
                                      : '--',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsRating'.tr(),
                                  text: widget.statistic?.games?.rating?.toStringAsFixed(1) ?? '--',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsCaptain'.tr(),
                                  text: widget.statistic?.games?.captain ?? false ? 'playerStatisticsYes'.tr() : 'playerStatisticsNo'.tr(),
                                ),
                                const SizedBox(height: 12),

                                ///
                                /// SHOTS
                                ///
                                Text(
                                  'playerStatisticsShots'.tr(),
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsTotal'.tr(),
                                  text: '${widget.statistic?.shots?.shotsTotal ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsOn'.tr(),
                                  text: '${widget.statistic?.shots?.shotsOn ?? '--'}',
                                ),
                                const SizedBox(height: 12),

                                ///
                                /// SHOTS
                                ///
                                Text(
                                  'playerStatisticsSubstitutes'.tr(),
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsIn'.tr(),
                                  text: '${widget.statistic?.substitutes?.playerIn ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsOut'.tr(),
                                  text: '${widget.statistic?.substitutes?.playerOut ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsBench'.tr(),
                                  text: '${widget.statistic?.substitutes?.playerBench ?? '--'}',
                                ),
                                const SizedBox(height: 12),

                                ///
                                /// GOALS
                                ///
                                Text(
                                  'playerStatisticsGoals'.tr(),
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsTotal'.tr(),
                                  text: '${widget.statistic?.goals?.total ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsConceded'.tr(),
                                  text: '${widget.statistic?.goals?.conceded ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsAssists'.tr(),
                                  text: '${widget.statistic?.goals?.assists ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsSaves'.tr(),
                                  text: '${widget.statistic?.goals?.saves ?? '--'}',
                                ),
                                const SizedBox(height: 12),

                                ///
                                /// PASSES
                                ///
                                Text(
                                  'playerStatisticsPasses'.tr(),
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsTotal'.tr(),
                                  text: '${widget.statistic?.passes?.total ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsKey'.tr(),
                                  text: '${widget.statistic?.passes?.key ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsAccuracy'.tr(),
                                  text: widget.statistic?.passes?.accuracy != null ? '${widget.statistic?.passes?.accuracy}%' : '--',
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///
                                /// TACKLES
                                ///
                                Text(
                                  'playerStatisticsTackles'.tr(),
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsTotal'.tr(),
                                  text: '${widget.statistic?.tackles?.total ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsBlocks'.tr(),
                                  text: '${widget.statistic?.tackles?.blocks ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsInterceptions'.tr(),
                                  text: '${widget.statistic?.tackles?.interceptions ?? '--'}',
                                ),
                                const SizedBox(height: 12),

                                ///
                                /// DUELS
                                ///
                                Text(
                                  'playerStatisticsDuels'.tr(),
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsTotal'.tr(),
                                  text: '${widget.statistic?.duels?.total ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsWon'.tr(),
                                  text: '${widget.statistic?.duels?.won ?? '--'}',
                                ),
                                const SizedBox(height: 12),

                                ///
                                /// DRIBBLES
                                ///
                                Text(
                                  'playerStatisticsDribbles'.tr(),
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsAttempts'.tr(),
                                  text: '${widget.statistic?.dribbles?.attempts ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsSuccess'.tr(),
                                  text: '${widget.statistic?.dribbles?.success ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsPast'.tr(),
                                  text: '${widget.statistic?.dribbles?.past ?? '--'}',
                                ),
                                const SizedBox(height: 12),

                                ///
                                /// FOULS
                                ///
                                Text(
                                  'playerStatisticsFouls'.tr(),
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsDrawn'.tr(),
                                  text: '${widget.statistic?.fouls?.drawn ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsCommited'.tr(),
                                  text: '${widget.statistic?.fouls?.commited ?? '--'}',
                                ),
                                const SizedBox(height: 12),

                                ///
                                /// CARDS
                                ///
                                Text(
                                  'playerStatisticsCards'.tr(),
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsYellow'.tr(),
                                  text: '${widget.statistic?.cards?.yellow ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsRed'.tr(),
                                  text: '${widget.statistic?.cards?.red ?? '--'}',
                                ),
                                const SizedBox(height: 12),

                                ///
                                /// PENALTIES
                                ///
                                Text(
                                  'playerStatisticsPenalties'.tr(),
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsWon'.tr(),
                                  text: '${widget.statistic?.penalty?.won ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsCommited'.tr(),
                                  text: '${widget.statistic?.penalty?.commited ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsScored'.tr(),
                                  text: '${widget.statistic?.penalty?.scored ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsMissed'.tr(),
                                  text: '${widget.statistic?.penalty?.missed ?? '--'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'playerStatisticsSaved'.tr(),
                                  text: '${widget.statistic?.penalty?.saved ?? '--'}',
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
}
