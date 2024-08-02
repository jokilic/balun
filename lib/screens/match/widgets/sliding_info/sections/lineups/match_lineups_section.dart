import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/lineup/lineup.dart';
import '../../../../../../theme/theme.dart';
import 'match_lineup_content.dart';

class MatchLineupsSection extends StatelessWidget {
  final Lineup? homeLineup;
  final Lineup? awayLineup;

  const MatchLineupsSection({
    required this.homeLineup,
    required this.awayLineup,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          children: [
            ///
            /// HOME
            ///
            MatchLineupContent(
              lineup: homeLineup,
            ),

            ///
            /// DIVIDER
            ///
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 80,
                vertical: 20,
              ),
              height: 4,
              color: context.colors.greenish,
            ),

            ///
            /// AWAY
            ///
            MatchLineupContent(
              lineup: awayLineup,
            ),

            const SizedBox(height: 24),
          ],
        ),
      );
}
