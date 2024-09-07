import 'package:flutter/material.dart';

import '../../../models/teams/team/team.dart';
import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image.dart';

class TeamAppBar extends StatelessWidget {
  final Function() onPressed;
  final Team? team;

  const TeamAppBar({
    required this.onPressed,
    required this.team,
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
              child: const BalunImage(
                imageUrl: BalunIcons.back,
                height: 32,
                width: 32,
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
                if (team?.name != null)
                  Text(
                    team!.name!,
                    style: context.textStyles.matchLeagueName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (team?.country != null)
                  Text(
                    team!.country!,
                    style: context.textStyles.matchLeagueRound,
                  ),
              ],
            ),
          ),
        ],
      );
}
