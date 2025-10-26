import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image.dart';

class FavoritesAppBar extends StatelessWidget {
  final Function() onPressed;

  const FavoritesAppBar({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
    child: Row(
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
              Text(
                'settingsFavoritesTitle'.tr(),
                style: context.textStyles.matchLeagueName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'settingsFavoritesSubtitle'.tr(),
                style: context.textStyles.matchLeagueRound,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
