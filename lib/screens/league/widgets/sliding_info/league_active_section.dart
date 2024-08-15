import 'package:flutter/material.dart';

import '../../../../models/league_section.dart';
import '../../../../models/leagues/league_response.dart';
import 'sections/fixtures/league_fixtures_section.dart';
import 'sections/standings/league_standings_section.dart';
import 'sections/teams/league_teams_section.dart';
import 'sections/top_assists/league_top_assists_section.dart';
import 'sections/top_red_cards/league_top_red_cards_section.dart';
import 'sections/top_scorers/league_top_scorers_section.dart';
import 'sections/top_yellow_cards/league_top_yellow_cards_section.dart';

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
          LeagueFixturesSection(
            leagueId: league.league?.id,
            season: activeSeason,
          ),
        LeagueSection(
          leagueSectionEnum: LeagueSectionEnum.topScorers,
        ) =>
          LeagueTopScorersSection(
            leagueId: league.league?.id,
            season: activeSeason,
          ),
        LeagueSection(
          leagueSectionEnum: LeagueSectionEnum.topAssists,
        ) =>
          LeagueTopAssistsSection(
            leagueId: league.league?.id,
            season: activeSeason,
          ),
        LeagueSection(
          leagueSectionEnum: LeagueSectionEnum.topYellowCards,
        ) =>
          LeagueTopYellowCardsSection(
            leagueId: league.league?.id,
            season: activeSeason,
          ),
        LeagueSection(leagueSectionEnum: LeagueSectionEnum.topRedCards) => LeagueTopRedCardsSection(
            leagueId: league.league?.id,
            season: activeSeason,
          ),
      };
}
