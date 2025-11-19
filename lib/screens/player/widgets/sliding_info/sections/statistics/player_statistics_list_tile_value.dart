import 'package:flutter/material.dart';

import '../../../../../../theme/theme.dart';

class PlayerStatisticsListTileValue extends StatelessWidget {
  final String title;
  final String text;

  const PlayerStatisticsListTileValue({
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                title,
                style: context.textStyles.bodyMdLight,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: context.textStyles.bodyMd,
              ),
            )
          ],
        ),
      );
}
