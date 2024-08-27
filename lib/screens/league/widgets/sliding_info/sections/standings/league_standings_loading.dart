import 'package:flutter/material.dart';

import '../../../../../../theme/theme.dart';

class LeagueStandingsLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          children: [
            Container(
              height: 40,
              width: 104,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.colors.black.withOpacity(0.25),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 32,
                  width: 104,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.colors.black.withOpacity(0.15),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.colors.black.withOpacity(0.15),
              ),
            ),
          ],
        ),
      );
}
