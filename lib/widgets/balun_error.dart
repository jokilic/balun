import 'package:flutter/material.dart';

import '../theme/icons.dart';
import '../theme/theme.dart';
import 'balun_image.dart';

class BalunError extends StatelessWidget {
  final String error;
  final double verticalPadding;

  const BalunError({
    required this.error,
    this.verticalPadding = 104,
  });

  @override
  Widget build(BuildContext context) => Center(
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 40,
            vertical: verticalPadding,
          ),
          children: [
            const Center(
              child: BalunImage(
                imageUrl: BalunIcons.error,
                height: 144,
                width: 144,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              error,
              style: context.textStyles.error,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}
