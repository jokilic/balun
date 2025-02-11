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
import 'fixtures_list_tile_logo.dart';
import 'fixtures_list_tile_minute.dart';

class FixturesListTile extends StatelessWidget {
  final FixtureResponse fixture;
  final bool fixturePlaying;
  final Function()? fixturePressed;

  const FixturesListTile({
    required this.fixture,
    required this.fixturePlaying,
    required this.fixturePressed,
  });

  @override
  Widget build(BuildContext context) => BalunButton(
        onPressed: fixturePressed,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: context.colors.white.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
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
                  FixturesListTileLogo(
                    logo: fixture.teams?.home?.logo ?? BalunIcons.placeholderTeam,
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
                      timeBeforeMatch: isMatchNotStarted(
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
                  FixturesListTileLogo(
                    logo: fixture.teams?.away?.logo ?? BalunIcons.placeholderTeam,
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
                      style: context.textStyles.fixturesName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  ///
                  /// SCORE
                  ///
                  Expanded(
                    child: fixturePlaying
                        ? Animate(
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
                                    style: context.textStyles.fixturesScore.copyWith(
                                      color: context.colors.greenish,
                                    ),
                                  ),
                                  TextSpan(text: '${fixture.goals?.away ?? '-'}'),
                                ],
                              ),
                              style: context.textStyles.fixturesScore,
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: '${fixture.goals?.home ?? '-'}'),
                                TextSpan(
                                  text: ':',
                                  style: context.textStyles.fixturesScore.copyWith(
                                    color: context.colors.greenish,
                                  ),
                                ),
                                TextSpan(text: '${fixture.goals?.away ?? '-'}'),
                              ],
                            ),
                            style: context.textStyles.fixturesScore,
                            textAlign: TextAlign.center,
                          ),
                  ),

                  ///
                  /// AWAY NAME
                  ///
                  Expanded(
                    child: Text(
                      mixOrOriginalWords(fixture.teams?.away?.name) ?? '---',
                      style: context.textStyles.fixturesName,
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
      );
}
