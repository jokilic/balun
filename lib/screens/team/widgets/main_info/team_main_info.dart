import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/teams/team_response.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/balun_image.dart';
import '../team_app_bar.dart';

class TeamMainInfo extends StatelessWidget {
  final TeamResponse team;

  const TeamMainInfo({
    required this.team,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ///
            /// BACK & TEAM NAME
            ///
            TeamAppBar(
              onPressed: Navigator.of(context).pop,
              team: team.team,
            ),

            const SizedBox(height: 48),

            ///
            /// LOGO
            ///
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: BalunImage(
                imageUrl: team.team?.logo ?? BalunImages.placeholderLogo,
                fit: BoxFit.contain,
                height: 120,
                width: 120,
              ),
            ),

            const SizedBox(height: 16),

            ///
            /// NAME
            ///
            Text(
              team.team?.name ?? 'No name',
              style: context.textStyles.leagueName,
              textAlign: TextAlign.center,
            ),

            ///
            /// COUNTRY
            ///
            if (team.team?.country != null)
              Text(
                team.team?.country ?? 'No name',
                style: context.textStyles.leagueCountry,
                textAlign: TextAlign.center,
              ),

            ///
            /// FOUNDED
            ///
            if (team.team?.founded != null) ...[
              const SizedBox(height: 4),
              Text(
                'Founded ${team.team?.founded}',
                style: context.textStyles.teamFounded,
                textAlign: TextAlign.center,
              ),
            ],

            const SizedBox(height: 32),
          ],
        ),
      );
}
