import 'package:flutter/material.dart';

import '../../../../models/team_section.dart';
import '../../../../models/teams/team_response.dart';
import 'sections/stadium/team_stadium_section.dart';

class TeamActiveSection extends StatelessWidget {
  final TeamResponse team;
  final TeamSection teamSection;

  const TeamActiveSection({
    required this.team,
    required this.teamSection,
  });

  @override
  Widget build(BuildContext context) => switch (teamSection) {
        TeamSection(
          teamSectionEnum: TeamSectionEnum.stadium,
        ) =>
          TeamStadiumSection(
            stadium: team.venue,
          ),
        TeamSection(
          teamSectionEnum: TeamSectionEnum.leagues,
        ) =>
          Container(),
        TeamSection(
          teamSectionEnum: TeamSectionEnum.standings,
        ) =>
          Container(),
        TeamSection(
          teamSectionEnum: TeamSectionEnum.coaches,
        ) =>
          Container(),
        TeamSection(
          teamSectionEnum: TeamSectionEnum.players,
        ) =>
          Container(),
        TeamSection(
          teamSectionEnum: TeamSectionEnum.transfers,
        ) =>
          Container(),
      };
}
