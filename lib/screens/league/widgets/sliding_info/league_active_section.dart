import 'package:flutter/material.dart';

import '../../../../models/league_section.dart';
import '../../../../models/leagues/league_response.dart';
import 'sections/teams/league_teams_section.dart';

class LeagueActiveSection extends StatelessWidget {
  final LeagueResponse league;
  final LeagueSection leagueSection;

  const LeagueActiveSection({
    required this.league,
    required this.leagueSection,
  });

  @override
  Widget build(BuildContext context) => switch (leagueSection) {
        LeagueSection(
          leagueSectionEnum: LeagueSectionEnum.teams,
        ) =>
          LeagueTeamsSection(
            leagueId: league.league?.id,
            season: league.seasons?.first.year,
          ),
        LeagueSection(
          leagueSectionEnum: LeagueSectionEnum.standings,
        ) =>
          Container(),
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
