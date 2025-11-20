import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../widgets/balun_image.dart';

class StatusListTile extends StatelessWidget {
  final String icon;
  final String title;
  final String? subtitle;

  const StatusListTile({
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        BalunImage(
          imageUrl: icon,
          height: 48,
          width: 48,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.textStyles.titleMd,
              ),
              if (subtitle?.isNotEmpty ?? false)
                Text(
                  subtitle!,
                  style: context.textStyles.bodyMdLightMuted,
                ),
            ],
          ),
        ),
      ],
    ),
  );
}
