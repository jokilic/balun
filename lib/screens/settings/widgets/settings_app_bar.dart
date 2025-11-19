import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image.dart';

class SettingsAppBar extends StatelessWidget {
  final Function() onPressed;

  const SettingsAppBar({
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
        /// ICON
        ///
        BalunButton(
          onPressed: () {},
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.primaryBackgroundLight,
            ),
            child: BalunImage(
              imageUrl: BalunIcons.settings,
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
          child: Text(
            'settingsTitle'.tr(),
            style: context.textStyles.titleLgBold,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
