import 'package:flutter/material.dart';

import '../../../models/search_section.dart';
import 'sections/coaches/search_coaches_section.dart';
import 'sections/countries/search_countries_section.dart';
import 'sections/leagues/search_leagues_section.dart';
import 'sections/players/search_players_section.dart';
import 'sections/teams/search_teams_section.dart';

class SearchActiveSection extends StatelessWidget {
  final SearchSection searchSection;

  const SearchActiveSection({
    required this.searchSection,
  });

  @override
  Widget build(BuildContext context) => switch (searchSection) {
        SearchSection(
          searchSectionEnum: SearchSectionEnum.countries,
        ) =>
          SearchCountriesSection(),
        SearchSection(
          searchSectionEnum: SearchSectionEnum.leagues,
        ) =>
          SearchLeaguesSection(),
        SearchSection(
          searchSectionEnum: SearchSectionEnum.teams,
        ) =>
          SearchTeamsSection(),
        SearchSection(
          searchSectionEnum: SearchSectionEnum.players,
        ) =>
          SearchPlayersSection(),
        SearchSection(
          searchSectionEnum: SearchSectionEnum.coaches,
        ) =>
          SearchCoachesSection(),
      };
}
