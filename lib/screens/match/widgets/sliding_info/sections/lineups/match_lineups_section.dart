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
            /// NO LINEUPS
            ///
            if (homeLineup == null && awayLineup == null)
              // TODO: Implement empty state
              const Text('No lineups')
            else ...[
              ///
              /// HOME
              ///
              if (homeLineup != null)
                MatchLineupContent(
                  lineup: homeLineup,
                ),

              ///
              /// DIVIDER
              ///
              if (homeLineup != null && awayLineup != null)
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
              if (awayLineup != null)
                MatchLineupContent(
                  lineup: awayLineup,
                ),
            ],
            const SizedBox(height: 24),
          ],
        ),
      );
}
