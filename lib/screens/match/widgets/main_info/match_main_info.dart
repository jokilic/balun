import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../constants.dart';
import '../../../../models/fixtures/fixture_response.dart';
import '../../../../routing.dart';
import '../../../../services/match_storage_service.dart';
import '../../../../theme/icons.dart';
import '../../../../theme/theme.dart';
import '../../../../util/date_time.dart';
import '../../../../util/dependencies.dart';
import '../../../../util/events.dart';
import '../../../../util/match.dart';
import '../../../../util/snackbars.dart';
import '../../../../util/string.dart';
import '../../../../util/word_mix.dart';
import '../../../../widgets/balun_button.dart';
import '../match_app_bar.dart';
import 'match_logo.dart';
import 'match_minute.dart';

class MatchMainInfo extends WatchingWidget {
  final FixtureResponse match;
  final String? homeScoreRegular;
  final String? awayScoreRegular;
  final String? homeScoreExtraTime;
  final String? awayScoreExtraTime;
  final String? homeScorePenalties;
  final String? awayScorePenalties;
  final bool matchPlaying;
  final bool matchFinishedExtraTime;
  final bool matchFinishedPenalties;
  final bool isHomeWinner;
  final bool isAwayWinner;

  const MatchMainInfo({
    required this.match,
    required this.homeScoreRegular,
    required this.awayScoreRegular,
    required this.homeScoreExtraTime,
    required this.awayScoreExtraTime,
    required this.homeScorePenalties,
    required this.awayScorePenalties,
    required this.matchPlaying,
    required this.matchFinishedExtraTime,
    required this.matchFinishedPenalties,
    required this.isHomeWinner,
    required this.isAwayWinner,
  });

  Widget getTextWidget(BuildContext context) => Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: homeScoreRegular ?? '-',
          style: context.textStyles.displayXxxl.copyWith(
            color: context.colors.primaryForeground.withValues(
              alpha: (!isHomeWinner && !isAwayWinner) || isHomeWinner ? 1 : 0.4,
            ),
          ),
        ),
        TextSpan(
          text: ':',
          style: context.textStyles.displayXxxl.copyWith(
            color: context.colors.primaryForeground.withValues(alpha: 0.2),
          ),
        ),
        TextSpan(
          text: awayScoreRegular ?? '-',
          style: context.textStyles.displayXxxl.copyWith(
            color: context.colors.primaryForeground.withValues(
              alpha: (!isHomeWinner && !isAwayWinner) || isAwayWinner ? 1 : 0.4,
            ),
          ),
        ),
      ],
    ),
    style: context.textStyles.displayXxxl,
    textAlign: TextAlign.center,
  );

  Widget? getBottomTextWidget(BuildContext context) {
    /// Return penalties
    if (matchFinishedPenalties && (homeScorePenalties?.isNotEmpty ?? false) && (awayScorePenalties?.isNotEmpty ?? false)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.colors.datePickerActiveBackground.withValues(alpha: 0.5),
            ),
            child: Text(
              'fixturesPenalties'.tr(),
              style: context.textStyles.bodyLgBold,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$homeScorePenalties:$awayScorePenalties',
            style: context.textStyles.bodyLgBold,
          ),
        ],
      );
    }

    /// Return extra time
    if (matchFinishedExtraTime && (homeScoreExtraTime?.isNotEmpty ?? false) && (awayScoreExtraTime?.isNotEmpty ?? false)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.colors.datePickerActiveBackground.withValues(alpha: 0.5),
            ),
            child: Text(
              'fixturesExtraTime'.tr(),
              style: context.textStyles.bodyLgBold,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$homeScoreExtraTime:$awayScoreExtraTime',
            style: context.textStyles.bodyLgBold,
          ),
        ],
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final favoritedMatches = watchIt<MatchStorageService>().value;

    final textWidget = getTextWidget(context);
    final bottomTextWidget = getBottomTextWidget(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),

          ///
          /// BACK & LEAGUE
          ///
          MatchAppBar(
            onBackPressed: Navigator.of(context).pop,
            league: match.league!,
            onFavoritePressed: () async {
              unawaited(
                HapticFeedback.lightImpact(),
              );

              final matchAdded = await getIt.get<MatchStorageService>().toggleMatch(
                passedMatch: getFavoriteMatch(
                  match: match,
                ),
              );

              if (matchAdded ?? false) {
                showSnackbar(
                  context,
                  icon: BalunIcons.notificationMatch,
                  text: 'snackbarFavoriteMatch'.tr(),
                );
              }
            },
            isFavorited: favoritedMatches.any(
              (element) => element.matchId == match.fixture?.id,
            ),
          ),

          const SizedBox(height: 48),

          ///
          /// LOGOS, TEAM NAMES & MINUTE
          ///
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///
              /// HOME
              ///
              Expanded(
                child: BalunButton(
                  onPressed: match.teams?.home?.id != null
                      ? () {
                          HapticFeedback.lightImpact();
                          openTeam(
                            context,
                            teamId: match.teams!.home!.id!,
                            season: match.league?.season ?? getCurrentSeasonYear().toString(),
                          );
                        }
                      : null,
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        ///
                        /// HOME LOGO
                        ///
                        MatchLogo(
                          logo: match.teams?.home?.logo ?? BalunIcons.placeholderTeam,
                        ),

                        const SizedBox(height: 16),

                        ///
                        /// HOME NAME
                        ///
                        Text(
                          mixOrOriginalWords(match.teams?.home?.name) ?? '---',
                          style: context.textStyles.bodyLgBold,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ///
              /// MINUTE
              ///
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    MatchMinute(
                      minutes: getMatchMinutesOrNull(
                        statusShort: match.fixture?.status?.short ?? '--',
                        minutes: match.fixture?.status?.elapsed ?? 0,
                        extra: match.fixture?.status?.extra,
                      ),
                      textStatus: getMatchStatusShortOrNull(
                        statusShort: match.fixture?.status?.short ?? '--',
                      ),
                      timeBeforeMatch:
                          isMatchNotStarted(
                                statusShort: match.fixture?.status?.short ?? '--',
                              ) &&
                              match.fixture?.timestamp != null
                          ? DateFormat(
                              'HH:mm',
                              context.locale.toLanguageTag(),
                            ).format(
                              parseTimestamp(
                                match.fixture!.timestamp,
                              )!,
                            )
                          : null,
                    ),
                  ],
                ),
              ),

              ///
              /// AWAY
              ///
              Expanded(
                child: BalunButton(
                  onPressed: match.teams?.away?.id != null
                      ? () {
                          HapticFeedback.lightImpact();
                          openTeam(
                            context,
                            teamId: match.teams!.away!.id!,
                            season: match.league?.season ?? getCurrentSeasonYear().toString(),
                          );
                        }
                      : null,
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        ///
                        /// AWAY LOGO
                        ///
                        MatchLogo(
                          logo: match.teams?.away?.logo ?? BalunIcons.placeholderTeam,
                        ),

                        const SizedBox(height: 16),

                        ///
                        /// AWAY NAME
                        ///
                        Text(
                          mixOrOriginalWords(match.teams?.away?.name) ?? '---',
                          style: context.textStyles.bodyLgBold,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          ///
          /// SCORE & GOALSCORERS
          ///
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///
              /// HOME SCORERS
              ///
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    if (match.events?.isNotEmpty ?? false)
                      ...match.events!
                          .where(
                            (event) {
                              final isGoal = event.team?.id == match.teams?.home?.id && event.type?.toLowerCase() == 'goal' && event.detail?.toLowerCase() != 'missed penalty';

                              final isGoalFromPenaltyShootout = isGoal && event.comments?.toLowerCase() == 'penalty shootout';

                              return isGoal && !isGoalFromPenaltyShootout;
                            },
                          )
                          .map(
                            (event) {
                              final playerName = mixOrOriginalWords(getLastWord(event.player?.name ?? '---')) ?? '---';

                              return BalunButton(
                                onPressed: event.player?.id != null
                                    ? () {
                                        HapticFeedback.lightImpact();
                                        openPlayer(
                                          context,
                                          playerId: event.player!.id!,
                                          season: match.league?.season ?? getCurrentSeasonYear().toString(),
                                        );
                                      }
                                    : null,
                                child: Container(
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(vertical: 2),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getEventMinuteText(
                                          event,
                                          shortExtraTime: true,
                                        ),
                                        style: context.textStyles.labelMedium.copyWith(
                                          color: context.colors.primaryForeground.withValues(alpha: 0.4),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          event.detail?.toLowerCase() == 'penalty'
                                              ? '$playerName (${'matchInfoPenalty'.tr()})'
                                              : event.detail?.toLowerCase() == 'own goal'
                                              ? '$playerName (${'matchInfoOwnGoal'.tr()})'
                                              : playerName,
                                          style: context.textStyles.labelMedium,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                          .toList(),
                  ],
                ),
              ),

              ///
              /// SCORE
              ///
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    ///
                    /// MAIN TEXT
                    ///
                    if (matchPlaying)
                      Animate(
                        onPlay: (controller) => controller.loop(
                          reverse: true,
                          min: 0.3,
                        ),
                        effects: const [
                          FadeEffect(
                            curve: Curves.easeIn,
                            duration: BalunConstants.shimmerDuration,
                          ),
                        ],
                        child: textWidget,
                      )
                    else
                      textWidget,

                    ///
                    /// BOTTOM TEXT
                    ///
                    if (bottomTextWidget != null) ...[
                      const SizedBox(height: 8),
                      bottomTextWidget,
                    ],
                  ],
                ),
              ),

              ///
              /// AWAY SCORERS
              ///
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    if (match.events?.isNotEmpty ?? false)
                      ...match.events!
                          .where(
                            (event) {
                              final isGoal = event.team?.id == match.teams?.away?.id && event.type?.toLowerCase() == 'goal' && event.detail?.toLowerCase() != 'missed penalty';

                              final isGoalFromPenaltyShootout = isGoal && event.comments?.toLowerCase() == 'penalty shootout';

                              return isGoal && !isGoalFromPenaltyShootout;
                            },
                          )
                          .map(
                            (event) {
                              final playerName = mixOrOriginalWords(getLastWord(event.player?.name ?? '---')) ?? '---';

                              return BalunButton(
                                onPressed: event.player?.id != null
                                    ? () {
                                        HapticFeedback.lightImpact();
                                        openPlayer(
                                          context,
                                          playerId: event.player!.id!,
                                          season: match.league?.season ?? getCurrentSeasonYear().toString(),
                                        );
                                      }
                                    : null,
                                child: Container(
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(vertical: 2),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          event.detail?.toLowerCase() == 'penalty'
                                              ? '$playerName (${'matchInfoPenalty'.tr()})'
                                              : event.detail?.toLowerCase() == 'own goal'
                                              ? '$playerName (${'matchInfoOwnGoal'.tr()})'
                                              : playerName,
                                          style: context.textStyles.labelMedium,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        getEventMinuteText(
                                          event,
                                          shortExtraTime: true,
                                        ),
                                        style: context.textStyles.labelMedium.copyWith(
                                          color: context.colors.primaryForeground.withValues(alpha: 0.4),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                          .toList(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
