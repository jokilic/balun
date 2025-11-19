import 'package:flutter/material.dart';

import '../../../models/players/player/player.dart';
import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../util/string.dart';
import '../../../util/word_mix.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image.dart';

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
            color: context.colors.primaryBackground.withValues(alpha: 0.4),
          ),
          child: BalunImage(
            imageUrl: BalunIcons.back,
            height: 32,
            width: 32,
            color: context.colors.primaryForeground,
          ),
        ),
      ),

      const SizedBox(width: 14),

      ///
      /// TEXT
      ///
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (player?.name != null)
              Text(
                mixOrOriginalWords(player!.name) ?? '---',
                style: context.textStyles.titleLgBold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            if (player?.nationality != null)
              Text(
                mixOrOriginalWords(
                      getCountryName(
                        country: player!.nationality!,
                      ),
                    ) ??
                    '---',
                style: context.textStyles.labelMediumMuted,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    ],
  );
}
