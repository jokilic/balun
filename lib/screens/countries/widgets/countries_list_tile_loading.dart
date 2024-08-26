import 'package:flutter/material.dart';

import '../../../../../../theme/theme.dart';
import '../../../util/color.dart';

class CountriesListTileLoading extends StatelessWidget {
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
              width: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: getRandomBalunColor(context),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              height: 24,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.colors.black.withOpacity(0.25),
              ),
            ),
          ],
        ),
      );
}
