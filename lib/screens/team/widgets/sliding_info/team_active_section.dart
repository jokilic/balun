import 'package:flutter/material.dart';

import '../../../../models/team_section.dart';
import '../../../../models/teams/team_response.dart';
import 'sections/coaches/team_coaches_section.dart';
import 'sections/leagues/team_leagues_section.dart';
import 'sections/players/team_players_section.dart';
import 'sections/stadium/team_stadium_section.dart';
import 'sections/standings/team_standings_section.dart';

class TeamActiveSection extends StatelessWidget {
  final TeamResponse team;
  final TeamSection teamSection;
  final int season;

  const TeamActiveSection({
    required this.team,
    required this.teamSection,
    required this.season,
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
          TeamLeaguesSection(
            teamId: team.team?.id,
          ),
        TeamSection(
          teamSectionEnum: TeamSectionEnum.standings,
        ) =>
          TeamStandingsSection(
            teamId: team.team?.id,
            season: season,
          ),
        TeamSection(
          teamSectionEnum: TeamSectionEnum.coaches,
        ) =>
          TeamCoachesSection(
            teamId: team.team?.id,
          ),
        TeamSection(
          teamSectionEnum: TeamSectionEnum.players,
        ) =>
          TeamPlayersSection(
            teamId: team.team?.id,
          ),
        TeamSection(
          teamSectionEnum: TeamSectionEnum.transfers,
        ) =>
          Container(),
      };
}
