import 'package:flutter/material.dart';

import '../../../../../constants.dart';
import '../../../../../models/fixtures/fixture_response.dart';
import '../../../../../theme/theme.dart';
import '../../../../../util/string.dart';
import '../../../../../widgets/balun_button.dart';
import 'fixtures_list_tile_logo.dart';
import 'fixtures_list_tile_minute.dart';

class FixturesListTile extends StatelessWidget {
  final FixtureResponse fixture;
  final Function()? fixturePressed;

  const FixturesListTile({
    required this.fixture,
    required this.fixturePressed,
  });

  @override
  Widget build(BuildContext context) => BalunButton(
        onPressed: fixturePressed,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
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
                    logo: fixture.teams?.home?.logo ?? BalunImages.placeholderIcon,
                  ),

                  ///
                  /// MINUTE
                  ///
                  FixturesListTileMinute(
                    status: getMatchStatusMinutes(
                      statusShort: fixture.fixture?.status?.short ?? '?',
                      minutes: fixture.fixture?.status?.elapsed ?? 0,
                    ),
                  ),

                  ///
                  /// AWAY LOGO
                  ///
                  FixturesListTileLogo(
                    logo: fixture.teams?.away?.logo ?? BalunImages.placeholderIcon,
                  ),
                ],
              ),

              const SizedBox(height: 20),

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
                      fixture.teams?.home?.name ?? '---',
                      style: context.textStyles.fixturesName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  ///
                  /// SCORE
                  ///
                  Expanded(
                    flex: 2,
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
                  ),

                  ///
                  /// AWAY NAME
                  ///
                  Expanded(
                    child: Text(
                      fixture.teams?.away?.name ?? '---',
                      style: context.textStyles.fixturesName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
