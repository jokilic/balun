import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/fixture_response.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/date_time.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';

class LeagueFixturesListTile extends StatelessWidget {
  final FixtureResponse fixture;
  final Function() fixturePressed;

  const LeagueFixturesListTile({
    required this.fixture,
    required this.fixturePressed,
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
          color: context.colors.black.withOpacity(0.075),
          border: Border.all(
            color: context.colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  matchDateTime != null
                      ? DateFormat(
                          'd. MMMM y.',
                          context.locale.toLanguageTag(),
                        ).format(matchDateTime)
                      : '---',
                  style: context.textStyles.matchH2HTitle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  matchDateTime != null
                      ? DateFormat(
                          'HH:mm',
                          context.locale.toLanguageTag(),
                        ).format(matchDateTime)
                      : '---',
                  style: context.textStyles.matchH2HText,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ///
                /// HOME
                ///
                Expanded(
                  child: Column(
                    children: [
                      BalunImage(
                        imageUrl: fixture.teams?.home?.logo ?? BalunIcons.placeholderTeam,
                        height: 56,
                        width: 56,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        fixture.teams?.home?.name ?? '---',
                        style: context.textStyles.matchH2HTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 24),

                ///
                /// SCORE
                ///
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
                Expanded(
                  child: Column(
                    children: [
                      BalunImage(
                        imageUrl: fixture.teams?.away?.logo ?? BalunIcons.placeholderTeam,
                        height: 56,
                        width: 56,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        fixture.teams?.away?.name ?? '---',
                        style: context.textStyles.matchH2HTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
