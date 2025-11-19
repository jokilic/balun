import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/squads/player/player.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/players.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';

class TeamPlayersListTile extends StatelessWidget {
  final Player player;
  final String season;

  const TeamPlayersListTile({
    required this.player,
    required this.season,
  });

  @override
  Widget build(BuildContext context) => BalunButton(
    onPressed: player.id != null
        ? () => openPlayer(
            context,
            playerId: player.id!,
            season: season,
          )
        : null,
    child: Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          ///
          /// PHOTO
          ///
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BalunImage(
              imageUrl: player.photo ?? BalunIcons.placeholderPlayer,
              height: 48,
              width: 48,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///
                /// NAME
                ///
                if (player.name != null)
                  Text(
                    mixOrOriginalWords(player.name) ?? '---',
                    style: context.textStyles.titleMd,
                  ),

                ///
                /// AGE
                ///
                if (player.age != null) ...[
                  Text(
                    '${player.age!} ${'teamCoachesYearsOld'.tr()}',
                    style: context.textStyles.bodyMdLightMuted,
                  ),
                  const SizedBox(width: 12),
                ],
              ],
            ),
          ),

          ///
          /// POSITION
          ///
          if (player.position != null)
            Container(
              alignment: Alignment.center,
              width: 36,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: getPositionColor(
                  player.position!,
                  context: context,
                ),
                border: Border.all(
                  color: context.colors.primaryForeground,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                getPositionText(
                      player.position!,
                    ) ??
                    '--',
                style: context.textStyles.bodyLgBoldOnPrimary,
              ),
            ),
        ],
      ),
    ),
  );
}
