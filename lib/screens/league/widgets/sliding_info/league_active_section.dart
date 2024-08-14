import 'package:flutter/material.dart';

import '../../../../models/league_section.dart';
import '../../../../models/leagues/league_response.dart';
import 'sections/standings/league_standings_section.dart';
import 'sections/teams/league_teams_section.dart';

class LeagueActiveSection extends StatelessWidget {
  final LeagueResponse league;
  final LeagueSection leagueSection;
  final int activeSeason;

  const LeagueActiveSection({
    required this.league,
    required this.leagueSection,
    required this.activeSeason,
  });

  @override
  Widget build(BuildContext context) => switch (leagueSection) {
        LeagueSection(
          leagueSectionEnum: LeagueSectionEnum.teams,
        ) =>
          LeagueTeamsSection(
            leagueId: league.league?.id,
            season: activeSeason,
          ),
        LeagueSection(
          leagueSectionEnum: LeagueSectionEnum.standings,
        ) =>
          LeagueStandingsSection(
            leagueId: league.league?.id,
            season: activeSeason,
          ),
        LeagueSection(
          leagueSectionEnum: LeagueSectionEnum.fixtures,
        ) =>
          Container(),
        LeagueSection(
          leagueSectionEnum: LeagueSectionEnum.topScorers,
        ) =>
          Container(),
        LeagueSection(
          leagueSectionEnum: LeagueSectionEnum.topAssists,
        ) =>
          Container(),
        LeagueSection(
          leagueSectionEnum: LeagueSectionEnum.topYellowCards,
        ) =>
          Container(),
        LeagueSection(leagueSectionEnum: LeagueSectionEnum.topRedCards) => Container(),
      };
}
