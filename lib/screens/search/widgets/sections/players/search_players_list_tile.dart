import 'package:flutter/material.dart';

import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';
import '../../../../../models/search/search_players/search_player_response.dart';
import '../../../../../theme/icons.dart';
import '../../../../../util/word_mix.dart';

class SearchPlayersListTile extends StatelessWidget {
  final SearchPlayerResponse player;
  final Function()? playerPressed;

  const SearchPlayersListTile({
    required this.player,
    required this.playerPressed,
  });

  @override
  Widget build(BuildContext context) => BalunButton(
        onPressed: playerPressed,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: BalunImage(
                  imageUrl: player.player?.photo ?? BalunIcons.placeholderPlayer,
                  height: 40,
                  width: 40,
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mixOrOriginalWords(player.player?.name) ?? '---',
                      style: context.textStyles.fixturesLeague,
                    ),
                    if (player.player?.nationality != null)
                      Text(
                        mixOrOriginalWords(player.player!.nationality) ?? '---',
                        style: context.textStyles.leaguesSubtitle,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
