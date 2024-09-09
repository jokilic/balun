import 'package:flutter/material.dart';

import '../../../../../../models/fixtures/lineup/lineup.dart';
import '../../../../../../widgets/balun_empty.dart';
import 'match_lineup_content.dart';

class MatchLineupsSection extends StatelessWidget {
  final Lineup? homeLineup;
  final Lineup? awayLineup;
  final int season;

  const MatchLineupsSection({
    required this.homeLineup,
    required this.awayLineup,
    required this.season,
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
              const BalunEmpty(
                message: 'No lineups',
                isSmall: true,
              )

            ///
            /// FIELD
            ///
            else
              MatchLineupContent(
                homeLineup: homeLineup,
                awayLineup: awayLineup,
                season: season,
              ),

            const SizedBox(height: 24),
          ],
        ),
      );
}
