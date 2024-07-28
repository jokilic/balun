import 'package:flutter/material.dart';

import '../../../../../../models/standings/league/league.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/standings.dart';
import 'match_standings_list_tile.dart';

class MatchStandingsContent extends StatelessWidget {
  final League league;

  const MatchStandingsContent({
    required this.league,
  });

  @override
  Widget build(BuildContext context) {
    final standings = getStandingsList(
      league: league,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        children: [
          if (standings?.isNotEmpty ?? false) ...[
            if (league.name != null) ...[
              Text(
                league.name!,
                style: context.textStyles.matchStandingsSectionTitle,
              ),
              const SizedBox(height: 2),
            ],
            if (league.season != null)
              Text(
                'Season ${league.season}',
                style: context.textStyles.matchStandingsSectionText,
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 36,
                  child: Text(
                    'PL',
                    style: context.textStyles.matchStandingsSectionText,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 36,
                  child: Text(
                    'GD',
                    style: context.textStyles.matchStandingsSectionText,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 36,
                  child: Text(
                    'PTS',
                    style: context.textStyles.matchStandingsSectionText,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...standings!
                .map(
                  (standing) => MatchStandingsListTile(
                    standing: standing,
                  ),
                )
                .toList(),
          ],
        ],
      ),
    );
  }
}
