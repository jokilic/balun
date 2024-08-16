import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/squads/player/player.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/players.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';

class TeamPlayersListTile extends StatelessWidget {
  final Player player;

  const TeamPlayersListTile({
    required this.player,
  });

  @override
  Widget build(BuildContext context) => BalunButton(
        onPressed: player.id != null
            ? () => openPlayer(
                  context,
                  playerId: player.id!,
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
                  imageUrl: player.photo ?? BalunImages.placeholderLogo,
                  height: 56,
                  width: 56,
                ),
              ),
              const SizedBox(width: 12),

              ///
              /// NAME
              ///
              if (player.name != null)
                Expanded(
                  child: Text(
                    player.name!,
                    style: context.textStyles.leagueTeamsTitle,
                  ),
                ),

              ///
              /// AGE
              ///
              if (player.age != null) ...[
                Text(
                  '${player.age!}y',
                  style: context.textStyles.leagueTeamsTitle,
                ),
                const SizedBox(width: 12),
              ],

              ///
              /// POSITION
              ///
              if (player.position != null)
                Container(
                  alignment: Alignment.center,
                  width: 44,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: getPositionColor(
                      player.position!,
                      context: context,
                    ),
                    border: Border.all(
                      color: context.colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    getPositionText(
                          player.position!,
                        ) ??
                        '--',
                    style: context.textStyles.matchPlayerStatisticsRating,
                  ),
                ),
            ],
          ),
        ),
      );
}
