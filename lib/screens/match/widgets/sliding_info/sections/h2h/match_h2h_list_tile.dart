import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../models/fixtures/fixture_response.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/date_time.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';

class MatchH2HListTile extends StatelessWidget {
  final FixtureResponse fixture;
  final Function() fixturePressed;

  const MatchH2HListTile({
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (fixture.league != null)
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fixture.league!.round ?? '---',
                          style: context.textStyles.matchH2HTitle,
                        ),
                        Text(
                          fixture.league!.name ?? '---',
                          style: context.textStyles.matchH2HText,
                        ),
                      ],
                    ),
                  ),
                if (matchDateTime != null)
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat('d. MMMM y.').format(matchDateTime),
                          style: context.textStyles.matchH2HTitle,
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          DateFormat('HH:mm').format(matchDateTime),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: BalunImage(
                    imageUrl: fixture.teams?.home?.logo ?? BalunIcons.placeholderTeam,
                    height: 56,
                    width: 56,
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: BalunImage(
                    imageUrl: fixture.teams?.away?.logo ?? BalunIcons.placeholderTeam,
                    height: 56,
                    width: 56,
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
