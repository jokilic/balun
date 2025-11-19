import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/fixtures/league/league.dart';
import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../util/word_mix.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image.dart';

class MatchAppBar extends StatelessWidget {
  final Function() onBackPressed;
  final Function() onFavoritePressed;
  final League league;
  final bool isFavorited;

  const MatchAppBar({
    required this.onBackPressed,
    required this.onFavoritePressed,
    required this.league,
    required this.isFavorited,
  });

  @override
  Widget build(BuildContext context) => Row(
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
            color: context.colors.primaryBackground.withValues(alpha: 0.4),
          ),
          child: const BalunImage(
            imageUrl: BalunIcons.back,
            height: 32,
            width: 32,
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
            if (league.name != null)
              Text(
                mixOrOriginalWords(league.name) ?? '---',
                style: context.textStyles.titleLgBold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            if (league.round != null)
              Text(
                mixOrOriginalWords(league.round) ?? '---',
                style: context.textStyles.labelMediumMuted,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),

      ///
      /// FAVORITE
      ///
      const SizedBox(width: 14),

      BalunButton(
        onPressed: onFavoritePressed,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colors.primaryBackground.withValues(alpha: 0.4),
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
