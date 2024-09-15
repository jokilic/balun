import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../../models/fixtures/event/event.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/string.dart';
import '../../../../../../widgets/balun_image.dart';

class MatchEventsListTile extends StatelessWidget {
  final Event event;
  final int? elapsed;
  final bool? isAwayTeam;
  final bool isSecondYellowCard;

  const MatchEventsListTile({
    required this.event,
    required this.elapsed,
    required this.isAwayTeam,
    required this.isSecondYellowCard,
  });

  @override
  Widget build(BuildContext context) {
    final eventTime = event.time?.elapsed != null ? (event.time?.elapsed ?? 0) + (event.time?.extra ?? 0) : null;

    final scoreWidget = getScoreWidget(
      elapsed: eventTime,
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
                    eventTime != null ? "$eventTime'" : '---',
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
                      isSecondYellowCard: isSecondYellowCard,
                      context: context,
                    ),
                  ),
                ),
                if (isAwayTeam ?? false) ...[
                  const SizedBox(width: 8),
                  Text(
                    eventTime != null ? "$eventTime'" : '---',
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
                        'matchEvents2ndHalf'.tr(),
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
                    'matchEventsFullTime'.tr(),
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
                    'matchEventsExtraTime'.tr(),
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
                    'matchEventsPenalties'.tr(),
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
    required bool isSecondYellowCard,
    required BuildContext context,
  }) =>
      switch (eventType.toLowerCase()) {
        ///
        /// GOAL
        ///
        'goal' => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///
              /// ASSIST
              ///
              if (event.assist?.name != null) ...[
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const BalunImage(
                        imageUrl: BalunIcons.assist,
                        height: 28,
                        width: 28,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          event.assist!.name!,
                          style: context.textStyles.matchEventsSectionText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
              ],

              ///
              /// SCORER
              ///
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BalunImage(
                      imageUrl: BalunIcons.ball,
                      height: 28,
                      width: 28,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: event.player?.name ?? '---',
                              style: context.textStyles.matchEventsSectionText.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (eventDetail.toLowerCase() == 'penalty')
                              TextSpan(
                                text: ' (P)',
                                style: context.textStyles.matchEventsSectionText,
                              ),
                            if (eventDetail.toLowerCase() == 'own goal')
                              TextSpan(
                                text: ' (${'matchInfoOwnGoal'.tr()})',
                                style: context.textStyles.matchEventsSectionText,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

        ///
        /// CARD
        ///
        'card' => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///
              /// PLAYER
              ///
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    getCardWidget(
                      eventDetail,
                      playerId: event.player?.id,
                      isSecondYellowCard: isSecondYellowCard,
                      context: context,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        event.player?.name ?? '---',
                        style: context.textStyles.matchEventsSectionText.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              ///
              /// REASON
              ///
              if (event.comments != null) ...[
                const SizedBox(height: 4),
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 36),
                      Flexible(
                        child: Text(
                          event.comments!,
                          style: context.textStyles.matchEventsSectionText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
                    BalunImage(
                      imageUrl: BalunIcons.playerOut,
                      height: 28,
                      width: 28,
                      color: context.colors.red,
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

              const SizedBox(height: 4),

              ///
              /// PLAYER IN
              ///
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BalunImage(
                      imageUrl: BalunIcons.playerIn,
                      height: 28,
                      width: 28,
                      color: context.colors.green,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        event.player?.name ?? '---',
                        style: context.textStyles.matchEventsSectionText.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
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
        'var' => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BalunImage(
                      imageUrl: BalunIcons.varIcon,
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
                        style: context.textStyles.matchEventsSectionText.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 36),
                    Flexible(
                      child: Text(
                        'VAR',
                        style: context.textStyles.matchEventsSectionText,
                      ),
                    ),
                  ],
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
              const BalunImage(
                imageUrl: BalunIcons.assist,
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

  Widget getCardWidget(
    String eventDetail, {
    required int? playerId,
    required bool isSecondYellowCard,
    required BuildContext context,
  }) =>
      switch (eventDetail.toLowerCase()) {
        'yellow card' => BalunImage(
            imageUrl: isSecondYellowCard ? BalunIcons.cards : BalunIcons.card,
            height: 28,
            width: 28,
            color: isSecondYellowCard ? null : context.colors.yellow,
          ),
        'red card' => BalunImage(
            imageUrl: BalunIcons.card,
            height: 28,
            width: 28,
            color: context.colors.red,
          ),
        _ => const BalunImage(
            imageUrl: BalunIcons.cards,
            height: 28,
            width: 28,
          ),
      };
}
