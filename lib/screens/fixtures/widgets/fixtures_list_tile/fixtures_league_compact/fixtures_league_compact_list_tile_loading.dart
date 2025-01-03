import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';
import '../../../../../util/color.dart';
import '../../../../../util/random.dart';

class FixturesLeagueCompactListTileLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: context.colors.white.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 28,
              width: 28,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: getRandomBalunColor(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    height: 16,
                    width: getRandomNumberFromBase(144),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: context.colors.black.withValues(alpha: 0.25),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 28,
              width: 28,
            ),
          ],
        ),
      );
}
