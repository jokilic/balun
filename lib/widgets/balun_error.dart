import 'package:flutter/material.dart';

import '../theme/icons.dart';
import '../theme/theme.dart';

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
            Center(
              child: Image.asset(
                BalunIcons.error,
                height: 144,
                width: 144,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              error,
              style: context.textStyles.error,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}
