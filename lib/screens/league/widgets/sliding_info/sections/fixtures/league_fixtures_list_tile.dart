import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/fixture_response.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/date_time.dart';
import '../../../../../../util/word_mix.dart';
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
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: context.colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: context.colors.black,
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Column(
              children: [
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
              ],
            ),
            const SizedBox(height: 12),
            Row(
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
                          style: context.textStyles.fixturesName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(width: 6),
                      BalunImage(
                        imageUrl: fixture.teams?.home?.logo ?? BalunIcons.placeholderTeam,
                        height: 40,
                        width: 40,
                      ),
                    ],
                  ),
                ),

                ///
                /// SCORE
                ///
                const SizedBox(width: 12),
                Text(
                  '${fixture.goals?.home ?? '-'}:${fixture.goals?.away ?? '-'}',
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
                        height: 40,
                        width: 40,
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          mixOrOriginalWords(fixture.teams?.away?.name) ?? '---',
                          style: context.textStyles.fixturesName,
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
          ],
        ),
      ),
    );
  }
}
