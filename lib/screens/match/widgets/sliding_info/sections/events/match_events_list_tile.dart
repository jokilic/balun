import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/event/event.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/string.dart';

class MatchEventsListTile extends StatelessWidget {
  final Event event;
  final int? elapsed;
  final bool? isAwayTeam;

  const MatchEventsListTile({
    required this.event,
    required this.elapsed,
    required this.isAwayTeam,
  });

  @override
  Widget build(BuildContext context) {
    final scoreWidget = getScoreWidget(
      elapsed: elapsed,
      eventType: event.type ?? '',
      eventDetail: event.detail ?? '',
      context: context,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: isAwayTeam ?? false ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: (event.type?.contains('time') ?? false)
            ? [
                if (scoreWidget != null)
                  Flexible(
                    child: scoreWidget,
                  ),
              ]
            : [
                if (!(isAwayTeam ?? false)) ...[
                  Text(
                    event.time?.elapsed != null ? "${event.time!.elapsed}'" : '---',
                    style: context.textStyles.matchEventsSectionTime,
                  ),
                  const SizedBox(width: 8),
                ],
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: context.colors.black.withOpacity(0.075),
                    ),
                    child: getEventWidget(
                      eventType: event.type ?? '',
                      eventDetail: event.detail ?? '',
                      context: context,
                    ),
                  ),
                ),
                if (isAwayTeam ?? false) ...[
                  const SizedBox(width: 8),
                  Text(
                    event.time?.elapsed != null ? "${event.time!.elapsed}'" : '---',
                    style: context.textStyles.matchEventsSectionTime,
                  ),
                ],
              ],
      ),
    );
  }

  Widget? getScoreWidget({
    required int? elapsed,
    required String eventType,
    required String eventDetail,
    required BuildContext context,
  }) =>
      switch (eventType.toLowerCase()) {
        ///
        /// HALF TIME
        ///
        'halftime' => (elapsed ?? 0) > 45
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        '2nd half',
                        style: context.textStyles.matchEventsSectionResult,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        eventDetail,
                        style: context.textStyles.matchEventsSectionResult,
                      ),
                    ),
                  ],
                ),
              )
            : null,

        ///
        /// FULL TIME
        ///
        'fulltime' => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'Match finished',
                    style: context.textStyles.matchEventsSectionResult,
                  ),
                ),
                Flexible(
                  child: Text(
                    eventDetail,
                    style: context.textStyles.matchEventsSectionResult,
                  ),
                ),
              ],
            ),
          ),

        ///
        /// EXTRA TIME
        ///
        'extratime' => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'Extra time',
                    style: context.textStyles.matchEventsSectionResult,
                  ),
                ),
                Flexible(
                  child: Text(
                    eventDetail,
                    style: context.textStyles.matchEventsSectionResult,
                  ),
                ),
              ],
            ),
          ),

        ///
        /// PENALTIES
        ///
        'penalty' => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'Penalties',
                    style: context.textStyles.matchEventsSectionResult,
                  ),
                ),
                Flexible(
                  child: Text(
                    eventDetail,
                    style: context.textStyles.matchEventsSectionResult,
                  ),
                ),
              ],
            ),
          ),

        ///
        /// UNKNOWN
        ///
        _ => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    eventType,
                    style: context.textStyles.matchEventsSectionResult,
                  ),
                ),
                Flexible(
                  child: Text(
                    eventDetail,
                    style: context.textStyles.matchEventsSectionResult,
                  ),
                ),
              ],
            ),
          ),
      };

  Widget getEventWidget({
    required String eventType,
    required String eventDetail,
    required BuildContext context,
  }) =>
      switch (eventType.toLowerCase()) {
        ///
        /// GOAL
        ///
        'goal' => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                BalunIcons.goalBall,
                height: 28,
                width: 28,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  eventDetail.toLowerCase() == 'penalty' ? '${event.player?.name ?? '---'} (P)' : event.player?.name ?? '---',
                  style: context.textStyles.matchEventsSectionText,
                ),
              ),
            ],
          ),

        ///
        /// CARD
        ///
        'card' => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                getCardIcon(eventDetail),
                height: 28,
                width: 28,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  event.player?.name ?? '---',
                  style: context.textStyles.matchEventsSectionText,
                ),
              ),
            ],
          ),

        ///
        /// SUBSTITUTION
        ///
        'subst' => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///
              /// PLAYER OUT
              ///
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      BalunIcons.playerOut,
                      height: 28,
                      width: 28,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        event.player?.name ?? '---',
                        style: context.textStyles.matchEventsSectionText,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 4),

              ///
              /// PLAYER IN
              ///
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      BalunIcons.playerIn,
                      height: 28,
                      width: 28,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        event.assist?.name ?? '---',
                        style: context.textStyles.matchEventsSectionText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

        ///
        /// VAR
        ///
        'var' => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                BalunIcons.varIcon,
                height: 28,
                width: 28,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  getEventText(
                    eventType: eventType,
                    eventDetail: eventDetail,
                  ),
                  style: context.textStyles.matchEventsSectionText,
                ),
              ),
            ],
          ),

        ///
        /// UNKNOWN
        ///
        _ => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                BalunIcons.event,
                height: 28,
                width: 28,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  eventDetail,
                  style: context.textStyles.matchEventsSectionText,
                ),
              ),
            ],
          ),
      };

  String getCardIcon(String eventDetail) => switch (eventDetail.toLowerCase()) {
        'yellow card' => BalunIcons.yellowCard,
        'red card' => BalunIcons.redCard,
        _ => BalunIcons.cards,
      };
}
