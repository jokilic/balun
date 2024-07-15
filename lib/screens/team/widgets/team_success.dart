import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/teams/team_response.dart';
import '../../../widgets/balun_image.dart';
import 'team_app_bar.dart';

class TeamSuccess extends StatelessWidget {
  final TeamResponse team;

  const TeamSuccess({
    required this.team,
  });

  @override
  Widget build(BuildContext context) => ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        children: [
          ///
          /// BACK & TEAM NAME
          ///
          TeamAppBar(
            onPressed: Navigator.of(context).pop,
            teamName: team.team?.name ?? 'No name',
          ),

          const SizedBox(height: 48),

          ///
          /// TEAM LOGO
          ///
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BalunImage(
              imageUrl: team.team?.logo ?? BalunImages.placeholderLogo,
              fit: BoxFit.contain,
              height: 184,
              width: 184,
            ),
          ),
        ],
      );
}
