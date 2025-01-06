import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/event/event.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/date_time.dart';
import '../../../../../../util/string.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image/balun_image.dart';

class MatchEventsListTile extends StatelessWidget {
  final Event event;
  final bool? isAwayTeam;
  final bool isSecondYellowCard;
  final String? season;

  const MatchEventsListTile({
    required this.event,
    required this.isAwayTeam,
    required this.isSecondYellowCard,
    required this.season,
  });

  @override
  Widget build(BuildContext context) {
    final elapsedTime = event.time?.elapsed;
    final extraTime = event.time?.extra;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: isAwayTeam ?? false ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
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
                color: context.colors.black.withValues(alpha: 0.075),
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
                    child: BalunButton(
                      onPressed: event.player?.id != null
                          ? () => openPlayer(
                                context,
                                playerId: event.player!.id!,
                                season: season ?? getCurrentSeasonYear().toString(),
                              )
                          : null,
                      child: Container(
                        color: Colors.transparent,
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
                                      text: mixOrOriginalWords(event.player?.name) ?? '---',
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
                      child: BalunButton(
                        onPressed: event.assist?.id != null
                            ? () => openPlayer(
                                  context,
                                  playerId: event.assist!.id!,
                                  season: season ?? getCurrentSeasonYear().toString(),
                                )
                            : null,
                        child: Container(
                          color: Colors.transparent,
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
                                  mixOrOriginalWords(event.assist!.name) ?? '---',
                                  style: context.textStyles.matchEventsSectionText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],

                  ///
                  /// SCORER
                  ///
                  Flexible(
                    child: BalunButton(
                      onPressed: event.player?.id != null
                          ? () => openPlayer(
                                context,
                                playerId: event.player!.id!,
                                season: season ?? getCurrentSeasonYear().toString(),
                              )
                          : null,
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BalunImage(
                              imageUrl: BalunIcons.ball,
                              color: eventDetail.toLowerCase() == 'own goal' ? context.colors.red : null,
                              height: 28,
                              width: 28,
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: mixOrOriginalWords(event.player?.name) ?? '---',
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
                child: BalunButton(
                  onPressed: event.player?.id != null
                      ? () => openPlayer(
                            context,
                            playerId: event.player!.id!,
                            season: season ?? getCurrentSeasonYear().toString(),
                          )
                      : null,
                  child: Container(
                    color: Colors.transparent,
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
                            mixOrOriginalWords(event.player?.name) ?? '---',
                            style: context.textStyles.matchEventsSectionText.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                child: BalunButton(
                  onPressed: event.assist?.id != null
                      ? () => openPlayer(
                            context,
                            playerId: event.assist!.id!,
                            season: season ?? getCurrentSeasonYear().toString(),
                          )
                      : null,
                  child: Container(
                    color: Colors.transparent,
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
                            mixOrOriginalWords(event.assist?.name) ?? '---',
                            style: context.textStyles.matchEventsSectionText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 4),

              ///
              /// PLAYER IN
              ///
              Flexible(
                child: BalunButton(
                  onPressed: event.player?.id != null
                      ? () => openPlayer(
                            context,
                            playerId: event.player!.id!,
                            season: season ?? getCurrentSeasonYear().toString(),
                          )
                      : null,
                  child: Container(
                    color: Colors.transparent,
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
                            mixOrOriginalWords(event.player?.name) ?? '---',
                            style: context.textStyles.matchEventsSectionText.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
