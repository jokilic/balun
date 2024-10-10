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
  final bool? isAwayTeam;
  final bool isSecondYellowCard;
  final bool matchFinishedRegularly;

  const MatchEventsListTile({
    required this.event,
    required this.isAwayTeam,
    required this.isSecondYellowCard,
    required this.matchFinishedRegularly,
  });

  @override
  Widget build(BuildContext context) {
    final elapsedTime = event.time?.elapsed;
    final extraTime = event.time?.extra;

    final matchTimeWidget = getMatchTimeWidget(
      eventType: event.type ?? '',
      eventDetail: event.detail ?? '',
      matchFinishedRegularly: matchFinishedRegularly,
      context: context,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: isAwayTeam ?? false ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: (event.type?.contains('time') ?? false)
            ? [
                if (matchTimeWidget != null)
                  Flexible(
                    child: matchTimeWidget,
                  ),
              ]
            : [
                if (!(isAwayTeam ?? false)) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        elapsedTime != null ? "$elapsedTime'" : '--',
                        style: context.textStyles.matchEventsSectionTime,
                      ),
                      if (extraTime != null)
                        Text(
                          '+$extraTime',
                          style: context.textStyles.matchEventsSectionTime.copyWith(
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 8),
                ],
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        elapsedTime != null ? "$elapsedTime'" : '--',
                        style: context.textStyles.matchEventsSectionTime,
                      ),
                      if (extraTime != null)
                        Text(
                          '+$extraTime',
                          style: context.textStyles.matchEventsSectionTime.copyWith(
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ],
              ],
      ),
    );
  }

  Widget? getMatchTimeWidget({
    required String eventType,
    required String eventDetail,
    required bool matchFinishedRegularly,
    required BuildContext context,
  }) =>
      switch (eventType.toLowerCase()) {
        ///
        /// HALF TIME
        ///
        'halftime' => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'matchEvents1stHalf'.tr(),
                    style: context.textStyles.matchEventsSectionResult,
                  ),
                ),
                Text(
                  eventDetail,
                  style: context.textStyles.matchEventsSectionResult,
                ),
              ],
            ),
          ),

        ///
        /// FULL TIME
        ///
        'fulltime' => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    matchFinishedRegularly ? 'matchEventsFullTime'.tr() : 'matchEventsFullTimeRegularTime'.tr(),
                    style: context.textStyles.matchEventsSectionResult,
                  ),
                ),
                Text(
                  eventDetail,
                  style: context.textStyles.matchEventsSectionResult,
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
                Expanded(
                  child: Text(
                    'matchEventsExtraTime'.tr(),
                    style: context.textStyles.matchEventsSectionResult,
                  ),
                ),
                Text(
                  eventDetail,
                  style: context.textStyles.matchEventsSectionResult,
                ),
              ],
            ),
          ),

        ///
        /// PENALTIES
        ///
        'penaltytime' => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'matchEventsPenalties'.tr(),
                    style: context.textStyles.matchEventsSectionResult,
                  ),
                ),
                Text(
                  eventDetail,
                  style: context.textStyles.matchEventsSectionResult,
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
                Expanded(
                  child: Text(
                    eventType,
                    style: context.textStyles.matchEventsSectionResult,
                  ),
                ),
                Text(
                  eventDetail,
                  style: context.textStyles.matchEventsSectionResult,
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
        'goal' => eventDetail.toLowerCase() == 'missed penalty'
            ? Column(
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
                        const BalunImage(
                          imageUrl: BalunIcons.missedPenalty,
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
                                    text: ' (${'matchInfoPenalty'.tr()})',
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

                  ///
                  /// MISSED PENALTY
                  ///
                  const SizedBox(height: 4),
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 36),
                        Flexible(
                          child: Text(
                            'matchInfoMissedPenalty'.tr(),
                            style: context.textStyles.matchEventsSectionText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
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
                                    text: ' (${'matchInfoPenalty'.tr()})',
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
                          getEventCommentText(
                            eventComment: event.comments!,
                          ),
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
                        'matchEventsVAR'.tr(),
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
                        getEventText(
                          eventType: eventType,
                          eventDetail: eventDetail,
                        ),
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
            imageUrl: isSecondYellowCard ? BalunIcons.cards : BalunIcons.yellowCard,
            height: 28,
            width: 28,
          ),
        'red card' => const BalunImage(
            imageUrl: BalunIcons.redCard,
            height: 28,
            width: 28,
          ),
        _ => const BalunImage(
            imageUrl: BalunIcons.cards,
            height: 28,
            width: 28,
          ),
      };
}
