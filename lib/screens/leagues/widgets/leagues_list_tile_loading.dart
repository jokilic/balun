import 'package:flutter/material.dart';

import '../../../../../../theme/theme.dart';
import '../../../util/color.dart';
import '../../../util/random.dart';

class LeaguesListTileLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    child: Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: getRandomBalunColor(context),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 24,
              width: getRandomNumberFromBase(240),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.colors.primaryForeground.withValues(alpha: 0.25),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 12,
              width: getRandomNumberFromBase(80),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.colors.primaryForeground.withValues(alpha: 0.15),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
