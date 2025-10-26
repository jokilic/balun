import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/fixtures/fixture_response.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/date_time.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';

class MatchH2HListTile extends StatelessWidget {
  final FixtureResponse fixture;
  final Function() fixturePressed;
  final bool fixturePlaying;

  const MatchH2HListTile({
    required this.fixture,
    required this.fixturePressed,
    required this.fixturePlaying,
  });

  @override
  Widget build(BuildContext context) {
    final matchDateTime = parseTimestamp(
      fixture.fixture?.timestamp,
    );

    return BalunButton(
      onPressed: fixturePressed,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colors.primaryForeground,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (fixture.league != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mixOrOriginalWords(fixture.league!.round) ?? '---',
                          style: context.textStyles.matchH2HTitle,
                        ),
                        Text(
                          mixOrOriginalWords(fixture.league!.name) ?? '---',
                          style: context.textStyles.matchH2HText,
                        ),
                      ],
                    ),
                  ),
                if (matchDateTime != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat(
                            'd. MMMM y.',
                            context.locale.toLanguageTag(),
                          ).format(matchDateTime),
                          style: context.textStyles.matchH2HTitle,
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          DateFormat(
                            'HH:mm',
                            context.locale.toLanguageTag(),
                          ).format(matchDateTime),
                          style: context.textStyles.matchH2HText,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///
                /// HOME
                ///
                BalunImage(
                  imageUrl: fixture.teams?.home?.logo ?? BalunIcons.placeholderTeam,
                  height: 56,
                  width: 56,
                ),

                const SizedBox(width: 24),

                ///
                /// SCORE
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
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: '${fixture.goals?.home ?? '-'}'),
                          TextSpan(
                            text: ':',
                            style: context.textStyles.matchH2HScore,
                          ),
                          TextSpan(text: '${fixture.goals?.away ?? '-'}'),
                        ],
                      ),
                      style: context.textStyles.matchH2HScore,
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: '${fixture.goals?.home ?? '-'}'),
                        TextSpan(
                          text: ':',
                          style: context.textStyles.matchH2HScore,
                        ),
                        TextSpan(text: '${fixture.goals?.away ?? '-'}'),
                      ],
                    ),
                    style: context.textStyles.matchH2HScore,
                    textAlign: TextAlign.center,
                  ),

                const SizedBox(width: 24),

                ///
                /// AWAY
                ///
                BalunImage(
                  imageUrl: fixture.teams?.away?.logo ?? BalunIcons.placeholderTeam,
                  height: 56,
                  width: 56,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
