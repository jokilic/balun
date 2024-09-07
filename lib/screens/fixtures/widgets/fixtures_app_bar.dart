import 'package:flutter/material.dart';

import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image.dart';

class FixturesAppBar extends StatelessWidget {
  final Function() onPressed;
  final String text;

  const FixturesAppBar({
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            ///
            /// BACK
            ///
            BalunButton(
              onPressed: onPressed,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.white.withOpacity(0.4),
                ),
                child: BalunImage(
                  imageUrl: BalunIcons.ballNavigation,
                  height: 32,
                  width: 32,
                  color: context.colors.black,
                ),
              ),
            ),

            const SizedBox(width: 20),

            ///
            /// TEXT
            ///
            Expanded(
              child: Text(
                text,
                style: context.textStyles.matchLeagueName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
}
