import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/lineup/lineup.dart';
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

            ///
            /// FIELD
            ///
            else
              MatchLineupContent(
                homeLineup: homeLineup,
                awayLineup: awayLineup,
              ),

            const SizedBox(height: 24),
          ],
        ),
      );
}
