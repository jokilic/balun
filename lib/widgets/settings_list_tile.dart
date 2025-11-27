import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/balun_button.dart';
import '../theme/icons.dart';
import 'balun_image.dart';

class SettingsListTile extends StatelessWidget {
  final String icon;
  final String title;
  final String? subtitle;
  final Function()? onPressed;
  final bool? isActive;

  const SettingsListTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onPressed,
    this.isActive,
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
                color: context.colors.primaryBackgroundLight,
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
          Expanded(
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
                if (subtitle?.isNotEmpty ?? false)
                  Text(
                    subtitle!,
                    style: context.textStyles.labelMediumMuted,
                  ),
              ],
            ),
          ),

          ///
          /// CHECKBOX
          ///
          if (isActive != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.primaryBackgroundLight,
              ),
              child: BalunImage(
                imageUrl: BalunIcons.notificationCheckbox,
                height: 28,
                width: 28,
                color: isActive! ? null : context.colors.accent,
              ),
            ),
          ],
        ],
      ),
    ),
  );
}
