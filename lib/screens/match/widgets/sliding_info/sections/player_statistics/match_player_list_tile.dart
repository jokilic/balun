import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/fixtures/player_statistic/player_statistic_data.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/player_statistics.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';

class MatchPlayerListTile extends StatefulWidget {
  final PlayerStatisticData? statisticData;

  const MatchPlayerListTile({
    required this.statisticData,
  });

  @override
  State<MatchPlayerListTile> createState() => _MatchPlayerListTileState();
}

class _MatchPlayerListTileState extends State<MatchPlayerListTile> {
  var expanded = false;

  void toggleExpanded() => setState(
        () => expanded = !expanded,
      );

  @override
  Widget build(BuildContext context) {
    final rating = widget.statisticData?.statistic?.first.games?.rating;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          ///
          /// NAME
          ///
          if (widget.statisticData?.player != null)
            BalunButton(
              onPressed: toggleExpanded,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: BalunImage(
                        imageUrl: widget.statisticData?.player?.photo ?? BalunImages.placeholderLogo,
                        height: 56,
                        width: 56,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.statisticData?.player?.name ?? '---',
                        style: context.textStyles.matchPlayerStatisticsName,
                      ),
                    ),
                    if (rating != null)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: getRatingColor(
                            rating,
                            context: context,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '$rating',
                          style: context.textStyles.matchPlayerStatisticsRating,
                        ),
                      ),
                  ],
                ),
              ),
            ),

          ///
          /// STATISTICS
          ///
          if (widget.statisticData?.statistic?.isNotEmpty ?? false) ...[
            AnimatedSize(
              duration: BalunConstants.animationDuration,
              curve: Curves.easeIn,
              child: Builder(
                builder: (context) {
                  final statistic = widget.statisticData!.statistic!.first;

                  return expanded
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
                                    /// INFO
                                    ///
                                    Text(
                                      'Info',
                                      style: context.textStyles.matchPlayerStatisticsTitle,
                                    ),
                                    const SizedBox(height: 8),
                                    MatchPlayerListTileValue(
                                      title: 'Rating',
                                      text: '${statistic.games?.rating ?? '---'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'Minutes',
                                      text: statistic.games?.minutes != null ? "${statistic.games?.minutes}'" : '---',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'Number',
                                      text: '${statistic.games?.number ?? '---'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'Position',
                                      text: statistic.games?.position ?? '---',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'Offsides',
                                      text: '${statistic.offsides ?? '---'}',
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
                                    MatchPlayerListTileValue(
                                      title: 'Total',
                                      text: '${statistic.shots?.total ?? '---'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'On',
                                      text: '${statistic.shots?.on ?? '---'}',
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
                                    MatchPlayerListTileValue(
                                      title: 'Total',
                                      text: '${statistic.goals?.total ?? '---'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'Conceded',
                                      text: '${statistic.goals?.conceded ?? '---'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'Assists',
                                      text: '${statistic.goals?.assists ?? '---'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'Saves',
                                      text: '${statistic.goals?.saves ?? '---'}',
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
                                    MatchPlayerListTileValue(
                                      title: 'Total',
                                      text: '${statistic.passes?.total ?? '---'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'Key',
                                      text: '${statistic.passes?.key ?? '---'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'Accuracy',
                                      text: statistic.passes?.accuracy != null ? '${statistic.passes?.accuracy}%' : '---',
                                    ),
                                    const SizedBox(height: 12),

                                    ///
                                    /// TACKLES
                                    ///
                                    Text(
                                      'Tackles',
                                      style: context.textStyles.matchPlayerStatisticsTitle,
                                    ),
                                    const SizedBox(height: 8),
                                    MatchPlayerListTileValue(
                                      title: 'Total',
                                      text: '${statistic.tackles?.total ?? '---'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'Blocks',
                                      text: '${statistic.tackles?.blocks ?? '---'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'Interceptions',
                                      text: '${statistic.tackles?.interceptions ?? '---'}',
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
                                    /// DUELS
                                    ///
                                    Text(
                                      'Duels',
                                      style: context.textStyles.matchPlayerStatisticsTitle,
                                    ),
                                    const SizedBox(height: 8),
                                    MatchPlayerListTileValue(
                                      title: 'Total',
                                      text: '${statistic.duels?.total ?? '---'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'Won',
                                      text: '${statistic.duels?.won ?? '---'}',
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
                                    MatchPlayerListTileValue(
                                      title: 'Attempts',
                                      text: '${statistic.dribbles?.attempts ?? '---'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'Success',
                                      text: '${statistic.dribbles?.success ?? '---'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'Past',
                                      text: '${statistic.dribbles?.past ?? '---'}',
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
                                    MatchPlayerListTileValue(
                                      title: 'Drawn',
                                      text: '${statistic.fouls?.drawn ?? '---'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'Commited',
                                      text: '${statistic.fouls?.commited ?? '---'}',
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
                                    MatchPlayerListTileValue(
                                      title: 'Yellow',
                                      text: '${statistic.cards?.yellow ?? '---'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'Red',
                                      text: '${statistic.cards?.red ?? '---'}',
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
                                    MatchPlayerListTileValue(
                                      title: 'Won',
                                      text: '${statistic.penalty?.won ?? '---'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'Commited',
                                      text: '${statistic.penalty?.commited ?? '---'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'Scored',
                                      text: '${statistic.penalty?.scored ?? '---'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'Missed',
                                      text: '${statistic.penalty?.missed ?? '---'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'Saved',
                                      text: '${statistic.penalty?.saved ?? '---'}',
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class MatchPlayerListTileValue extends StatelessWidget {
  final String title;
  final String text;

  const MatchPlayerListTileValue({
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                title,
                style: context.textStyles.matchPlayerStatisticsText,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: context.textStyles.matchPlayerStatisticsValue,
              ),
            )
          ],
        ),
      );
}
