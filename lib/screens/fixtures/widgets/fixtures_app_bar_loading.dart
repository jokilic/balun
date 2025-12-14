import 'package:flutter/material.dart';

import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../util/random.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image.dart';

class FixturesAppBarLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        ///
        /// ICON
        ///
        BalunButton(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.primaryBackgroundLight,
            ),
            child: BalunImage(
              imageUrl: BalunIcons.ballNavigation,
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
        Container(
          height: 24,
          width: getRandomNumberFromBase(200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.colors.primaryForeground.withValues(alpha: 0.25),
          ),
        ),
      ],
    ),
  );
}
