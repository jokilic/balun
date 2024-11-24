import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/fixtures/player_statistic/player_statistic_data.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/player_statistics.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';
import 'match_player_list_tile_value.dart';

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
    final yellowCards = widget.statisticData?.statistic?.first.cards?.yellow;
    final redCards = widget.statisticData?.statistic?.first.cards?.red;
    final goals = widget.statisticData?.statistic?.first.goals?.total;
    final assists = widget.statisticData?.statistic?.first.goals?.assists;
    final substitute = widget.statisticData?.statistic?.first.games?.substitute;

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
                    ///
                    /// PHOTO
                    ///
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: BalunImage(
                        imageUrl: widget.statisticData?.player?.photo ?? BalunIcons.placeholderPlayer,
                        height: 48,
                        width: 48,
                      ),
                    ),
                    const SizedBox(width: 12),

                    ///
                    /// NAME
                    ///
                    Expanded(
                      child: Text(
                        mixOrOriginalWords(widget.statisticData?.player?.name ?? '--') ?? '--',
                        style: context.textStyles.matchPlayerStatisticsName.copyWith(
                          color: (substitute ?? false) && rating == null ? context.colors.black.withOpacity(0.4) : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    ///
                    /// YELLOW CARDS
                    ///
                    if ((yellowCards ?? 0) > 0) ...[
                      BalunImage(
                        imageUrl: yellowCards == 1 ? BalunIcons.yellowCard : BalunIcons.cards,
                        height: 32,
                        width: 32,
                      ),
                      const SizedBox(width: 8),
                    ],

                    ///
                    /// RED CARDS
                    ///
                    if ((redCards ?? 0) > 0 && (yellowCards ?? 0) == 0) ...[
                      const BalunImage(
                        imageUrl: BalunIcons.redCard,
                        height: 32,
                        width: 32,
                      ),
                      const SizedBox(width: 8),
                    ],

                    ///
                    /// ASSISTS
                    ///
                    if ((assists ?? 0) > 0) ...[
                      const BalunImage(
                        imageUrl: BalunIcons.assist,
                        height: 32,
                        width: 32,
                      ),
                      const SizedBox(width: 8),
                    ],

                    ///
                    /// GOALS
                    ///
                    if ((goals ?? 0) > 0) ...[
                      const BalunImage(
                        imageUrl: BalunIcons.ball,
                        height: 32,
                        width: 32,
                      ),
                      const SizedBox(width: 8),
                    ],

                    ///
                    /// RATING
                    ///
                    if (rating != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: getRatingColor(
                            rating,
                            context: context,
                          ),
                          border: Border.all(
                            color: context.colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '$rating',
                          style: context.textStyles.matchPlayerStatisticsRating,
                        ),
                      ),
                    ],
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
                                      'matchPlayerInfo'.tr(),
                                      style: context.textStyles.matchPlayerStatisticsTitle,
                                    ),
                                    const SizedBox(height: 8),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerRating'.tr(),
                                      text: statistic.games?.rating?.toStringAsFixed(1) ?? '--',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerMinutes'.tr(),
                                      text: statistic.games?.minutes != null ? "${statistic.games?.minutes}'" : '--',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerNumber'.tr(),
                                      text: '${statistic.games?.number ?? '--'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerPosition'.tr(),
                                      text: statistic.games?.position ?? '--',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerOffsides'.tr(),
                                      text: '${statistic.offsides ?? '--'}',
                                    ),
                                    const SizedBox(height: 12),

                                    ///
                                    /// SHOTS
                                    ///
                                    Text(
                                      'matchPlayerShots'.tr(),
                                      style: context.textStyles.matchPlayerStatisticsTitle,
                                    ),
                                    const SizedBox(height: 8),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerTotal'.tr(),
                                      text: '${statistic.shots?.total ?? '--'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerOn'.tr(),
                                      text: '${statistic.shots?.on ?? '--'}',
                                    ),
                                    const SizedBox(height: 12),

                                    ///
                                    /// GOALS
                                    ///
                                    Text(
                                      'matchPlayerGoals'.tr(),
                                      style: context.textStyles.matchPlayerStatisticsTitle,
                                    ),
                                    const SizedBox(height: 8),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerTotal'.tr(),
                                      text: '${statistic.goals?.total ?? '--'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerConceded'.tr(),
                                      text: '${statistic.goals?.conceded ?? '--'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerAssists'.tr(),
                                      text: '${statistic.goals?.assists ?? '--'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerSaves'.tr(),
                                      text: '${statistic.goals?.saves ?? '--'}',
                                    ),
                                    const SizedBox(height: 12),

                                    ///
                                    /// PASSES
                                    ///
                                    Text(
                                      'matchPlayerPasses'.tr(),
                                      style: context.textStyles.matchPlayerStatisticsTitle,
                                    ),
                                    const SizedBox(height: 8),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerTotal'.tr(),
                                      text: '${statistic.passes?.total ?? '--'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerKey'.tr(),
                                      text: '${statistic.passes?.key ?? '--'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerAccuracy'.tr(),
                                      text: statistic.passes?.accuracy != null ? '${statistic.passes?.accuracy}%' : '--',
                                    ),
                                    const SizedBox(height: 12),

                                    ///
                                    /// TACKLES
                                    ///
                                    Text(
                                      'matchPlayerTackles'.tr(),
                                      style: context.textStyles.matchPlayerStatisticsTitle,
                                    ),
                                    const SizedBox(height: 8),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerTotal'.tr(),
                                      text: '${statistic.tackles?.total ?? '--'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerBlocks'.tr(),
                                      text: '${statistic.tackles?.blocks ?? '--'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerInterceptions'.tr(),
                                      text: '${statistic.tackles?.interceptions ?? '--'}',
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
                                      'matchPlayerDuels'.tr(),
                                      style: context.textStyles.matchPlayerStatisticsTitle,
                                    ),
                                    const SizedBox(height: 8),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerTotal'.tr(),
                                      text: '${statistic.duels?.total ?? '--'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerWon'.tr(),
                                      text: '${statistic.duels?.won ?? '--'}',
                                    ),
                                    const SizedBox(height: 12),

                                    ///
                                    /// DRIBBLES
                                    ///
                                    Text(
                                      'matchPlayerDribbles'.tr(),
                                      style: context.textStyles.matchPlayerStatisticsTitle,
                                    ),
                                    const SizedBox(height: 8),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerAttempts'.tr(),
                                      text: '${statistic.dribbles?.attempts ?? '--'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerSuccess'.tr(),
                                      text: '${statistic.dribbles?.success ?? '--'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerPast'.tr(),
                                      text: '${statistic.dribbles?.past ?? '--'}',
                                    ),
                                    const SizedBox(height: 12),

                                    ///
                                    /// FOULS
                                    ///
                                    Text(
                                      'matchPlayerFouls'.tr(),
                                      style: context.textStyles.matchPlayerStatisticsTitle,
                                    ),
                                    const SizedBox(height: 8),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerDrawn'.tr(),
                                      text: '${statistic.fouls?.drawn ?? '--'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerCommited'.tr(),
                                      text: '${statistic.fouls?.commited ?? '--'}',
                                    ),
                                    const SizedBox(height: 12),

                                    ///
                                    /// CARDS
                                    ///
                                    Text(
                                      'matchPlayerCards'.tr(),
                                      style: context.textStyles.matchPlayerStatisticsTitle,
                                    ),
                                    const SizedBox(height: 8),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerYellow'.tr(),
                                      text: '${statistic.cards?.yellow ?? '--'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerRed'.tr(),
                                      text: '${statistic.cards?.red ?? '--'}',
                                    ),
                                    const SizedBox(height: 12),

                                    ///
                                    /// PENALTIES
                                    ///
                                    Text(
                                      'matchPlayerPenalties'.tr(),
                                      style: context.textStyles.matchPlayerStatisticsTitle,
                                    ),
                                    const SizedBox(height: 8),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerWon'.tr(),
                                      text: '${statistic.penalty?.won ?? '--'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerCommited'.tr(),
                                      text: '${statistic.penalty?.commited ?? '--'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerScored'.tr(),
                                      text: '${statistic.penalty?.scored ?? '--'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerMissed'.tr(),
                                      text: '${statistic.penalty?.missed ?? '--'}',
                                    ),
                                    MatchPlayerListTileValue(
                                      title: 'matchPlayerSaved'.tr(),
                                      text: '${statistic.penalty?.saved ?? '--'}',
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
