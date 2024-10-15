import 'package:flutter/material.dart';

import '../../../../models/team_section.dart';
import '../../../../models/teams/team_response.dart';
import 'sections/coaches/team_coaches_section.dart';
import 'sections/leagues/team_leagues_section.dart';
import 'sections/players/team_players_section.dart';
import 'sections/stadium/team_stadium_section.dart';
import 'sections/standings/team_standings_section.dart';
import 'sections/transfers/team_transfers_section.dart';

class TeamActiveSection extends StatelessWidget {
  final TeamResponse team;
  final TeamSection teamSection;
  final String activeSeason;

  const TeamActiveSection({
    required this.team,
    required this.teamSection,
    required this.activeSeason,
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
            season: activeSeason,
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
            season: activeSeason,
          ),
        TeamSection(
          teamSectionEnum: TeamSectionEnum.transfers,
        ) =>
          TeamTransfersSection(
            teamId: team.team?.id,
          ),
      };
}
