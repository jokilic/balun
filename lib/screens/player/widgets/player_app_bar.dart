import 'package:flutter/material.dart';

import '../../../models/players/player/player.dart';
import '../../../theme/theme.dart';
import '../../../widgets/balun_button.dart';

class PlayerAppBar extends StatelessWidget {
  final Function() onPressed;
  final Player? player;

  const PlayerAppBar({
    required this.onPressed,
    required this.player,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          ///
          /// BACK
          ///
          BalunButton(
            onPressed: onPressed,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.white.withOpacity(0.4),
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                size: 32,
              ),
            ),
          ),

          const SizedBox(width: 20),

          ///
          /// TEXT
          ///
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (player?.name != null)
                  Text(
                    player!.name!,
                    style: context.textStyles.matchLeagueName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (player?.nationality != null)
                  Text(
                    player!.nationality!,
                    style: context.textStyles.matchLeagueRound,
                  ),
              ],
            ),
          ),
        ],
      );
}
