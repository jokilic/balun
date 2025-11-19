import 'package:flutter/material.dart';

import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../widgets/balun_image.dart';

class SettingsListTile extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final Function()? onPressed;

  const SettingsListTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => BalunButton(
    onPressed: onPressed,
    child: Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Row(
        children: [
          ///
          /// ICON
          ///
          BalunButton(
            onPressed: onPressed,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.primaryBackground.withValues(alpha: 0.4),
              ),
              child: BalunImage(
                imageUrl: icon,
                height: 36,
                width: 36,
              ),
            ),
          ),
          const SizedBox(width: 14),

          ///
          /// TEXT
          ///
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///
                /// TITLE
                ///
                Text(
                  title,
                  style: context.textStyles.bodyLgBold,
                ),

                ///
                /// SUBTITLE
                ///
                Text(
                  subtitle,
                  style: context.textStyles.labelMediumMuted,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
