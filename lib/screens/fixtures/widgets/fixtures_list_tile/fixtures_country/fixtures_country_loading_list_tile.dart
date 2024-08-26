import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';

class FixturesCountryLoadingListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.colors.white.withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              height: 24,
              width: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
      );
}
