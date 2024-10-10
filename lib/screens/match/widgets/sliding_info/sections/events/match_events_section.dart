import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/event/event.dart';
import '../../../../../../models/fixtures/score/score.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/events.dart';
import '../../../../../../widgets/balun_empty.dart';
import 'match_events_list_tile.dart';

class MatchEventsSection extends StatelessWidget {
  final List<Event>? eventsMatchTimeList;
  final Score? score;
  final int? elapsed;
  final int? awayTeamId;
  final bool matchFinished;
  final bool matchFinishedRegularly;

  const MatchEventsSection({
    required this.eventsMatchTimeList,
    required this.score,
    required this.elapsed,
    required this.awayTeamId,
    required this.matchFinished,
    required this.matchFinishedRegularly,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          children: (eventsMatchTimeList?.isNotEmpty ?? false)
              ? [
                  ///
                  /// MATCH STARTED
                  ///
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Text(
                          'matchEventsStarted'.tr(),
                          style: context.textStyles.matchEventsSectionResult,
                        ),
                      ],
                    ),
                  ),

                  ///
                  /// EVENTS
                  ///
                  ...eventsMatchTimeList!
                      .map(
                        (event) => MatchEventsListTile(
                          event: event,
                          isAwayTeam: event.team?.id == awayTeamId,
                          isSecondYellowCard: isSecondYellowCard(
                            eventsMatchTimeList ?? [],
                            event,
                          ),
                          matchFinishedRegularly: matchFinishedRegularly,
                        ),
                      )
                      .toList(),

                  ///
                  /// MATCH FINISHED
                  ///
                  if (matchFinished)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'matchEventsFullTime'.tr(),
                              style: context.textStyles.matchEventsSectionResult,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              getFinalScore(
                                    score: score,
                                  ) ??
                                  '-:-',
                              style: context.textStyles.matchEventsSectionResult,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 24),
                ]
              : [
                  BalunEmpty(
                    message: 'matchEventsNo'.tr(),
                    isSmall: true,
                  ),
                ],
        ),
      );
}
