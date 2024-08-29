import 'package:flutter/material.dart';

import '../../../../../models/search/search_leagues/search_league_response.dart';
import '../../../../../routing.dart';
import 'search_leagues_list_tile.dart';

class SearchLeaguesSuccess extends StatelessWidget {
  final List<SearchLeagueResponse> leagues;

  const SearchLeaguesSuccess({
    required this.leagues,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: leagues.length,
        itemBuilder: (_, index) {
          final league = leagues[index];

          return SearchLeaguesListTile(
            league: league,
            leaguePressed: league.league?.id != null
                ? () => openLeague(
                      context,
                      leagueId: league.league!.id!,
                      season: DateTime.now().year,
                    )
                : null,
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 4),
      );
}
