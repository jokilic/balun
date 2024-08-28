import 'package:flutter/material.dart';

import '../../../../../../models/trophies/trophy_response.dart';
import '../../../../../../theme/theme.dart';

class CoachTrophiesListTile extends StatelessWidget {
  final TrophyResponse trophy;

  const CoachTrophiesListTile({
    required this.trophy,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///
            /// PLACE
            ///
            if (trophy.place != null) ...[
              Text(
                trophy.place!,
                style: context.textStyles.teamCoachCareerTeam,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],

            ///
            /// SEASON
            ///
            if (trophy.season != null) ...[
              Text(
                trophy.season!,
                style: context.textStyles.teamTransferTeam,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],

            ///
            /// LEAGUE
            ///
            if (trophy.league != null) ...[
              Text(
                trophy.league!,
                style: context.textStyles.teamTransferTeam,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],

            ///
            /// COUNTRY
            ///
            if (trophy.country != null) ...[
              Text(
                trophy.country!,
                style: context.textStyles.leagueTeamsCountry,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
          ],
        ),
      );
}
