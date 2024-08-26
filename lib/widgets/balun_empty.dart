import 'package:flutter/material.dart';

import '../theme/icons.dart';
import '../theme/theme.dart';

class BalunEmpty extends StatelessWidget {
  final String message;
  final double verticalPadding;

  const BalunEmpty({
    required this.message,
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
                BalunIcons.goalBall,
                height: 144,
                width: 144,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              message,
              style: context.textStyles.error,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}
