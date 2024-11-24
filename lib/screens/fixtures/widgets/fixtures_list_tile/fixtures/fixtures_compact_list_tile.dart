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
  final String scoreText;
  final bool fixturePlaying;
  final Function()? fixturePressed;

  const FixturesCompactListTile({
    required this.fixture,
    required this.scoreText,
    required this.fixturePlaying,
    required this.fixturePressed,
  });

  @override
  Widget build(BuildContext context) => BalunButton(
        onPressed: fixturePressed,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: context.colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
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
                        style: context.textStyles.fixturesNameCompact,
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
                    min: 0.6,
                  ),
                  effects: const [
                    FadeEffect(
                      curve: Curves.easeIn,
                      duration: BalunConstants.shimmerDuration,
                    ),
                  ],
                  child: Text(
                    scoreText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textStyles.fixturesScoreCompact,
                    textAlign: TextAlign.center,
                  ),
                )
              else
                Text(
                  scoreText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textStyles.fixturesScoreCompact,
                  textAlign: TextAlign.center,
                ),
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
                        style: context.textStyles.fixturesNameCompact,
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
      );
}
