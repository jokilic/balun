import 'package:flutter/material.dart';

import '../../../models/leagues/league_response.dart';
import '../../../routing.dart';
import 'leagues_list_tile.dart';

class LeaguesSuccess extends StatelessWidget {
  final List<LeagueResponse> leagues;

  const LeaguesSuccess({
    required this.leagues,
  });

  @override
  Widget build(BuildContext context) => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: leagues.length,
        itemBuilder: (_, index) {
          final league = leagues[index];

          return LeaguesListTile(
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
      );
}