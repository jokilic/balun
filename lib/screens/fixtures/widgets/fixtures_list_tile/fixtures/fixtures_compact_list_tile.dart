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
  final String? homeScore;
  final String? awayScore;
  final String? status;
  final String? time;
  final bool fixturePlaying;
  final Function()? onFixturePressed;
  final Function()? onFixtureLongPressed;
  final bool isFavorited;

  const FixturesCompactListTile({
    required this.fixture,
    required this.homeScore,
    required this.awayScore,
    required this.status,
    required this.time,
    required this.fixturePlaying,
    required this.onFixturePressed,
    required this.onFixtureLongPressed,
    required this.isFavorited,
  });

  Widget getTextWidget(BuildContext context) {
    if ((homeScore?.isNotEmpty ?? false) && (awayScore?.isNotEmpty ?? false)) {
      return Text.rich(
        TextSpan(
          children: [
            TextSpan(text: '$homeScore'),
            const WidgetSpan(
              child: SizedBox(width: 2),
            ),
            TextSpan(
              text: ':',
              style: context.textStyles.titleLgBoldTight.copyWith(
                color: context.colors.primaryForeground.withValues(alpha: 0.2),
              ),
            ),
            const WidgetSpan(
              child: SizedBox(width: 2),
            ),
            TextSpan(text: '$awayScore'),
          ],
        ),
        style: context.textStyles.titleLgBoldTight,
        textAlign: TextAlign.center,
      );
    }

    return Text(
      time ?? status ?? '-',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.textStyles.titleLgBoldTight,
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textWidget = getTextWidget(context);

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
                horizontal: 8,
                vertical: 12,
              ),
              child: Row(
                children: [
                  ///
                  /// HOME
                  ///
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            mixOrOriginalWords(fixture.teams?.home?.name) ?? '---',
                            style: context.textStyles.bodyMd,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        const SizedBox(width: 6),
                        BalunImage(
                          imageUrl: fixture.teams?.home?.logo ?? BalunIcons.placeholderTeam,
                          height: 28,
                          width: 28,
                        ),
                      ],
                    ),
                  ),

                  ///
                  /// SCORE
                  ///
                  const SizedBox(width: 12),
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
                  const SizedBox(width: 12),

                  ///
                  /// AWAY
                  ///
                  Expanded(
                    child: Row(
                      children: [
                        BalunImage(
                          imageUrl: fixture.teams?.away?.logo ?? BalunIcons.placeholderTeam,
                          height: 28,
                          width: 28,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            mixOrOriginalWords(fixture.teams?.away?.name) ?? '---',
                            style: context.textStyles.bodyMd,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ),
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
