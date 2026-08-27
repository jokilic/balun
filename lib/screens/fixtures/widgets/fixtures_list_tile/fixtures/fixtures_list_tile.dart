import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../constants.dart';
import '../../../../../models/fixtures/fixture_response.dart';
import '../../../../../theme/icons.dart';
import '../../../../../theme/theme.dart';
import '../../../../../util/date_time.dart';
import '../../../../../util/string.dart';
import '../../../../../util/word_mix.dart';
import '../../../../../widgets/balun_button.dart';
import '../../../../../widgets/balun_image.dart';
import 'fixtures_list_tile_logo.dart';
import 'fixtures_list_tile_minute.dart';

class FixturesListTile extends StatelessWidget {
  final FixtureResponse fixture;
  final String? homeScoreRegular;
  final String? awayScoreRegular;
  final String? homeScoreExtraTime;
  final String? awayScoreExtraTime;
  final String? homeScorePenalties;
  final String? awayScorePenalties;
  final bool fixturePlaying;
  final bool fixtureFinishedExtraTime;
  final bool fixtureFinishedPenalties;
  final bool isHomeWinner;
  final bool isAwayWinner;
  final Function()? onFixturePressed;
  final Function()? onFixtureLongPressed;
  final bool isFavorited;

  const FixturesListTile({
    required this.fixture,
    required this.homeScoreRegular,
    required this.awayScoreRegular,
    required this.homeScoreExtraTime,
    required this.awayScoreExtraTime,
    required this.homeScorePenalties,
    required this.awayScorePenalties,
    required this.fixturePlaying,
    required this.fixtureFinishedExtraTime,
    required this.fixtureFinishedPenalties,
    required this.isHomeWinner,
    required this.isAwayWinner,
    required this.onFixturePressed,
    required this.onFixtureLongPressed,
    required this.isFavorited,
  });

  Widget getTextWidget(BuildContext context) {
    final homeScore = fixturePlaying ? fixture.goals?.home?.toString() ?? homeScoreRegular : homeScoreRegular;
    final awayScore = fixturePlaying ? fixture.goals?.away?.toString() ?? awayScoreRegular : awayScoreRegular;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: homeScore ?? '-',
              style: context.textStyles.displayXxl.copyWith(
                color: context.colors.primaryForeground.withValues(
                  alpha: (!isHomeWinner && !isAwayWinner) || isHomeWinner ? 1 : 0.5,
                ),
              ),
            ),
            TextSpan(
              text: ':',
              style: context.textStyles.displayXxl.copyWith(
                color: context.colors.primaryForeground.withValues(alpha: 0.2),
              ),
            ),
            TextSpan(
              text: awayScore ?? '-',
              style: context.textStyles.displayXxl.copyWith(
                color: context.colors.primaryForeground.withValues(
                  alpha: (!isHomeWinner && !isAwayWinner) || isAwayWinner ? 1 : 0.4,
                ),
              ),
            ),
          ],
        ),
        style: context.textStyles.displayXxl.copyWith(
          letterSpacing: 2,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget? getBottomTextWidget(BuildContext context) {
    /// Return penalties
    if (fixtureFinishedPenalties && (homeScorePenalties?.isNotEmpty ?? false) && (awayScorePenalties?.isNotEmpty ?? false)) {
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
    if (fixtureFinishedExtraTime && (homeScoreExtraTime?.isNotEmpty ?? false) && (awayScoreExtraTime?.isNotEmpty ?? false)) {
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
    final textWidget = getTextWidget(context);
    final bottomTextWidget = getBottomTextWidget(context);

    return BalunButton(
      onPressed: onFixturePressed,
      onLongPressed: onFixtureLongPressed,
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.fixtureListTileBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            ///
            /// CONTENT
            ///
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: Column(
                children: [
                  ///
                  /// LOGOS & MINUTE
                  ///
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///
                      /// HOME LOGO
                      ///
                      Flexible(
                        child: FixturesListTileLogo(
                          logo: fixture.teams?.home?.logo ?? BalunIcons.placeholderTeam,
                          hasProperLogo: fixture.teams?.home?.logo != null,
                        ),
                      ),

                      ///
                      /// MINUTE
                      ///
                      Flexible(
                        child: FixturesListTileMinute(
                          minutes: getMatchMinutesOrNull(
                            statusShort: fixture.fixture?.status?.short ?? '--',
                            minutes: fixture.fixture?.status?.elapsed ?? 0,
                            extra: fixture.fixture?.status?.extra,
                          ),
                          textStatus: getMatchStatusShortOrNull(
                            statusShort: fixture.fixture?.status?.short ?? '--',
                          ),
                          timeBeforeMatch:
                              isMatchNotStarted(
                                    statusShort: fixture.fixture?.status?.short ?? '--',
                                  ) &&
                                  fixture.fixture?.timestamp != null
                              ? DateFormat(
                                  'HH:mm',
                                  context.locale.toLanguageTag(),
                                ).format(
                                  parseTimestamp(
                                    fixture.fixture!.timestamp,
                                  )!,
                                )
                              : null,
                        ),
                      ),

                      ///
                      /// AWAY LOGO
                      ///
                      Flexible(
                        child: FixturesListTileLogo(
                          logo: fixture.teams?.away?.logo ?? BalunIcons.placeholderTeam,
                          hasProperLogo: fixture.teams?.away?.logo != null,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  ///
                  /// NAMES & SCORE
                  ///
                  Row(
                    children: [
                      ///
                      /// HOME NAME
                      ///
                      Expanded(
                        child: Text(
                          mixOrOriginalWords(fixture.teams?.home?.name) ?? '---',
                          style: context.textStyles.bodyLgBold,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      ///
                      /// SCORE
                      ///
                      Expanded(
                        child: Column(
                          children: [
                            ///
                            /// MAIN TEXT
                            ///
                            if (fixturePlaying)
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
                              const SizedBox(height: 6),
                              bottomTextWidget,
                            ],
                          ],
                        ),
                      ),

                      ///
                      /// AWAY NAME
                      ///
                      Expanded(
                        child: Text(
                          mixOrOriginalWords(fixture.teams?.away?.name) ?? '---',
                          style: context.textStyles.bodyLgBold,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            ///
            /// FAVORITE
            ///
            Positioned(
              right: -2,
              top: -3,
              child: AnimatedOpacity(
                opacity: isFavorited ? 1 : 0,
                duration: BalunConstants.animationDuration,
                curve: Curves.easeIn,
                child: BalunImage(
                  imageUrl: BalunIcons.favoriteYes,
                  height: 24,
                  width: 24,
                  color: context.colors.datePickerActiveBackground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
