import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/leagues/league/league.dart';
import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image.dart';

class LeagueAppBar extends StatelessWidget {
  final Function() onBackPressed;
  final Function() onFavoritePressed;
  final League league;
  final bool isFavorited;

  const LeagueAppBar({
    required this.onBackPressed,
    required this.onFavoritePressed,
    required this.league,
    required this.isFavorited,
  });

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///
          /// BACK
          ///
          BalunButton(
            onPressed: onBackPressed,
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
                if (league.name != null)
                  Text(
                    league.name!,
                    style: context.textStyles.matchLeagueName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (league.type != null)
                  Text(
                    league.type!,
                    style: context.textStyles.matchLeagueRound,
                  ),
              ],
            ),
          ),

          ///
          /// FAVORITE
          ///
          const SizedBox(width: 20),

          BalunButton(
            onPressed: onFavoritePressed,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.white.withOpacity(0.4),
              ),
              child: AnimatedSwitcher(
                duration: BalunConstants.longAnimationDuration,
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeIn,
                child: isFavorited
                    ? const BalunImage(
                        key: ValueKey('yes'),
                        imageUrl: BalunIcons.favoriteYes,
                        height: 32,
                        width: 32,
                      )
                    : const BalunImage(
                        key: ValueKey('no'),
                        imageUrl: BalunIcons.favoriteNo,
                        height: 32,
                        width: 32,
                      ),
              ),
            ),
          ),
        ],
      );
}
