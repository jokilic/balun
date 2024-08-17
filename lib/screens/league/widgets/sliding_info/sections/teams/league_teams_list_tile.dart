import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/teams/team_response.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';

class LeagueTeamsListTile extends StatelessWidget {
  final TeamResponse team;
  final int season;

  const LeagueTeamsListTile({
    required this.team,
    required this.season,
  });

  @override
  Widget build(BuildContext context) => BalunButton(
        onPressed: team.team?.id != null
            ? () => openTeam(
                  context,
                  teamId: team.team!.id!,
                  season: season,
                )
            : null,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              BalunImage(
                imageUrl: team.team?.logo ?? BalunImages.placeholderLogo,
                height: 56,
                width: 56,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (team.team?.name != null)
                      Text(
                        team.team!.name!,
                        style: context.textStyles.leagueTeamsTitle,
                      ),
                    if (team.team?.country != null)
                      Text(
                        team.team!.country!,
                        style: context.textStyles.leagueTeamsCountry,
                      ),
                    if (team.team?.founded != null)
                      Text(
                        'Founded ${team.team!.founded}',
                        style: context.textStyles.leagueTeamsFounded,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
