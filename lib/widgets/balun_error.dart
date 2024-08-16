import 'package:flutter/material.dart';

import '../theme/icons.dart';
import '../theme/theme.dart';

class BalunError extends StatelessWidget {
  final String error;

  const BalunError({
    required this.error,
  });

  @override
  Widget build(BuildContext context) => Center(
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 104,
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
