import 'package:flutter/material.dart';

import '../../../../../../models/standings/league/league.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/standings.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'league_standings_list_tile.dart';

class LeagueStandingsContent extends StatelessWidget {
  final League league;

  const LeagueStandingsContent({
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
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: standings?.length ?? 0,
              itemBuilder: (_, index) => LeagueStandingsListTile(
                standing: standings![index],
              ),
              separatorBuilder: (_, __) => const BalunSeperator(),
            ),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }
}
