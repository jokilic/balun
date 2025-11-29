import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image.dart';

class ThemeAppBar extends StatelessWidget {
  final Function() onPressed;

  const ThemeAppBar({
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
              color: context.colors.primaryBackgroundLight,
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
              Text(
                'themeAppBarTitle'.tr(),
                style: context.textStyles.titleLgBold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'themeAppBarSubtitle'.tr(),
                style: context.textStyles.labelMediumMuted,
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
