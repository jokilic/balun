import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/players/statistic/statistic.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';
import 'player_statistics_list_tile_value.dart';

class PlayerStatisticsListTile extends StatefulWidget {
  final Statistic? statistic;
  final int season;

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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: BalunImage(
                          imageUrl: widget.statistic?.team?.logo ?? BalunIcons.placeholderTeam,
                          height: 56,
                          width: 56,
                        ),
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
                              widget.statistic?.team?.name ?? '---',
                              style: context.textStyles.matchPlayerStatisticsName,
                            ),
                            Text(
                              widget.statistic?.league?.name ?? '---',
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
                                  'Games',
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'Appearences',
                                  text: '${widget.statistic?.games?.appearences ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Lineups',
                                  text: '${widget.statistic?.games?.lineups ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Minutes',
                                  text: widget.statistic?.games?.minutes != null ? "${widget.statistic?.games?.minutes}'" : '---',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Number',
                                  text: '${widget.statistic?.games?.number ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Position',
                                  text: widget.statistic?.games?.position ?? '---',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Rating',
                                  text: widget.statistic?.games?.rating?.toStringAsFixed(2) ?? '---',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Captain',
                                  text: widget.statistic?.games?.captain ?? false ? 'Yes' : 'No',
                                ),
                                const SizedBox(height: 12),

                                ///
                                /// SHOTS
                                ///
                                Text(
                                  'Shots',
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'Total',
                                  text: '${widget.statistic?.shots?.shotsTotal ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'On',
                                  text: '${widget.statistic?.shots?.shotsOn ?? '---'}',
                                ),
                                const SizedBox(height: 12),

                                ///
                                /// SHOTS
                                ///
                                Text(
                                  'Substitutes',
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'In',
                                  text: '${widget.statistic?.substitutes?.playerIn ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Out',
                                  text: '${widget.statistic?.substitutes?.playerOut ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Bench',
                                  text: '${widget.statistic?.substitutes?.playerBench ?? '---'}',
                                ),
                                const SizedBox(height: 12),

                                ///
                                /// GOALS
                                ///
                                Text(
                                  'Goals',
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'Total',
                                  text: '${widget.statistic?.goals?.total ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Conceded',
                                  text: '${widget.statistic?.goals?.conceded ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Assists',
                                  text: '${widget.statistic?.goals?.assists ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Saves',
                                  text: '${widget.statistic?.goals?.saves ?? '---'}',
                                ),
                                const SizedBox(height: 12),

                                ///
                                /// PASSES
                                ///
                                Text(
                                  'Passes',
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'Total',
                                  text: '${widget.statistic?.passes?.total ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Key',
                                  text: '${widget.statistic?.passes?.key ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Accuracy',
                                  text: widget.statistic?.passes?.accuracy != null ? '${widget.statistic?.passes?.accuracy}%' : '---',
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
                                  'Tackles',
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'Total',
                                  text: '${widget.statistic?.tackles?.total ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Blocks',
                                  text: '${widget.statistic?.tackles?.blocks ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Interceptions',
                                  text: '${widget.statistic?.tackles?.interceptions ?? '---'}',
                                ),
                                const SizedBox(height: 12),

                                ///
                                /// DUELS
                                ///
                                Text(
                                  'Duels',
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'Total',
                                  text: '${widget.statistic?.duels?.total ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Won',
                                  text: '${widget.statistic?.duels?.won ?? '---'}',
                                ),
                                const SizedBox(height: 12),

                                ///
                                /// DRIBBLES
                                ///
                                Text(
                                  'Dribbles',
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'Attempts',
                                  text: '${widget.statistic?.dribbles?.attempts ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Success',
                                  text: '${widget.statistic?.dribbles?.success ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Past',
                                  text: '${widget.statistic?.dribbles?.past ?? '---'}',
                                ),
                                const SizedBox(height: 12),

                                ///
                                /// FOULS
                                ///
                                Text(
                                  'Fouls',
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'Drawn',
                                  text: '${widget.statistic?.fouls?.drawn ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Commited',
                                  text: '${widget.statistic?.fouls?.commited ?? '---'}',
                                ),
                                const SizedBox(height: 12),

                                ///
                                /// CARDS
                                ///
                                Text(
                                  'Cards',
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'Yellow',
                                  text: '${widget.statistic?.cards?.yellow ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Red',
                                  text: '${widget.statistic?.cards?.red ?? '---'}',
                                ),
                                const SizedBox(height: 12),

                                ///
                                /// PENALTIES
                                ///
                                Text(
                                  'Penalties',
                                  style: context.textStyles.matchPlayerStatisticsTitle,
                                ),
                                const SizedBox(height: 8),
                                PlayerStatisticsListTileValue(
                                  title: 'Won',
                                  text: '${widget.statistic?.penalty?.won ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Commited',
                                  text: '${widget.statistic?.penalty?.commited ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Scored',
                                  text: '${widget.statistic?.penalty?.scored ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Missed',
                                  text: '${widget.statistic?.penalty?.missed ?? '---'}',
                                ),
                                PlayerStatisticsListTileValue(
                                  title: 'Saved',
                                  text: '${widget.statistic?.penalty?.saved ?? '---'}',
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
