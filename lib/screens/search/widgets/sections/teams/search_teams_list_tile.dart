import 'package:flutter/material.dart';

import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';
import '../../../../../models/search/search_teams/search_team_response.dart';
import '../../../../../theme/icons.dart';
import '../../../../../util/string.dart';

class SearchTeamsListTile extends StatelessWidget {
  final SearchTeamResponse team;
  final Function()? teamPressed;

  const SearchTeamsListTile({
    required this.team,
    required this.teamPressed,
  });

  @override
  Widget build(BuildContext context) => BalunButton(
        onPressed: teamPressed,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              BalunImage(
                imageUrl: team.team?.logo ?? BalunIcons.placeholderTeam,
                height: 40,
                width: 40,
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      team.team?.name ?? '---',
                      style: context.textStyles.fixturesLeague,
                    ),
                    if (team.team?.country != null)
                      Text(
                        getCountryName(
                          country: team.team!.country!,
                        ),
                        style: context.textStyles.leaguesSubtitle,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
