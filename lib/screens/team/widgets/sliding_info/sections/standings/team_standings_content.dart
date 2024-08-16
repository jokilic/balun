import 'package:flutter/material.dart';

import '../../../../../../models/standings/standing_response.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'team_standings_list_tile.dart';

class TeamStandingsContent extends StatelessWidget {
  final List<StandingResponse>? standings;
  final int? season;

  const TeamStandingsContent({
    required this.standings,
    required this.season,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ///
          /// SEASON
          ///
          Text(
            'Season $season',
            style: context.textStyles.leagueTeamsTitle,
          ),

          ///
          /// STANDINGS
          ///
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: standings?.length ?? 0,
            itemBuilder: (_, index) => TeamStandingsListTile(
              standing: standings![index],
            ),
            separatorBuilder: (_, __) => const BalunSeperator(),
          ),
        ],
      );
}
