import 'package:flutter/material.dart';

import '../../../../../models/search/search_players/search_player_response.dart';
import '../../../../../routing.dart';
import 'search_players_list_tile.dart';

class SearchPlayersSuccess extends StatelessWidget {
  final List<SearchPlayerResponse> players;

  const SearchPlayersSuccess({
    required this.players,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: players.length,
        itemBuilder: (_, index) {
          final player = players[index];

          return SearchPlayersListTile(
            player: player,
            playerPressed: player.player?.id != null
                ? () => openPlayer(
                      context,
                      playerId: player.player!.id!,
                      season: DateTime.now().year.toString(),
                    )
                : null,
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 4),
      );
}
