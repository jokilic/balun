import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../constants.dart';
import '../../../../../models/fixtures/fixture_response.dart';
import '../../../../../theme/icons.dart';
import '../../../../../theme/theme.dart';
import '../../../../../util/word_mix.dart';
import '../../../../../widgets/balun_button.dart';
import '../../../../../widgets/balun_image.dart';

class FixturesCompactListTile extends StatelessWidget {
  final FixtureResponse fixture;
  final String? homeScoreRegular;
  final String? awayScoreRegular;
  final String? homeScoreExtraTime;
  final String? awayScoreExtraTime;
  final String? homeScorePenalties;
  final String? awayScorePenalties;
  final String? status;
  final String? time;
  final bool fixturePlaying;
  final bool fixtureFinishedExtraTime;
  final bool fixtureFinishedPenalties;
  final Function()? onFixturePressed;
  final Function()? onFixtureLongPressed;
  final bool isFavorited;

  const FixturesCompactListTile({
    required this.fixture,
    required this.homeScoreRegular,
    required this.awayScoreRegular,
    required this.homeScoreExtraTime,
    required this.awayScoreExtraTime,
    required this.homeScorePenalties,
    required this.awayScorePenalties,
    required this.status,
    required this.time,
    required this.fixturePlaying,
    required this.fixtureFinishedExtraTime,
    required this.fixtureFinishedPenalties,
    required this.onFixturePressed,
    required this.onFixtureLongPressed,
    required this.isFavorited,
  });

  Widget getTextWidget(BuildContext context) {
    /// Return `scores`
    if ((homeScoreRegular?.isNotEmpty ?? false) && (awayScoreRegular?.isNotEmpty ?? false)) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          '$homeScoreRegular:$awayScoreRegular',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textStyles.titleMdBoldTight.copyWith(
            letterSpacing: 2,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    /// Return `time` or `status`
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: context.colors.accent,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        time ?? status ?? '-',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.textStyles.titleMdBoldTight,
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
              style: context.textStyles.labelBold,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$homeScorePenalties:$awayScorePenalties',
            style: context.textStyles.labelBold,
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
              style: context.textStyles.labelBold,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$homeScoreExtraTime:$awayScoreExtraTime',
            style: context.textStyles.labelBold,
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
              child: Row(
                children: [
                  ///
                  /// HOME
                  ///
                  Expanded(
                    child: Row(
                      children: [
                        BalunImage(
                          imageUrl: fixture.teams?.home?.logo ?? BalunIcons.placeholderTeam,
                          height: 28,
                          width: 28,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            mixOrOriginalWords(fixture.teams?.home?.name) ?? '---',
                            style: context.textStyles.bodyMdBold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///
                  /// SCORE
                  ///
                  const SizedBox(width: 12),
                  Column(
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
                        const SizedBox(height: 2),
                        bottomTextWidget,
                      ],
                    ],
                  ),

                  const SizedBox(width: 12),

                  ///
                  /// AWAY
                  ///
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            mixOrOriginalWords(fixture.teams?.away?.name) ?? '---',
                            style: context.textStyles.bodyMdBold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(width: 8),
                        BalunImage(
                          imageUrl: fixture.teams?.away?.logo ?? BalunIcons.placeholderTeam,
                          height: 28,
                          width: 28,
                        ),
                      ],
                    ),
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
                  height: 20,
                  width: 20,
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
