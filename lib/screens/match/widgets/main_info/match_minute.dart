import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class MatchMinute extends StatelessWidget {
  final int minutes;

  const MatchMinute({
    required this.minutes,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: context.colors.black.withOpacity(0.2),
            width: 1.5,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Text(
              '$minutes',
              style: context.textStyles.fixturesMinute,
              textAlign: TextAlign.center,
            ),
            Positioned(
              right: -6,
              child: Text(
                "'",
                style: context.textStyles.fixturesMinute,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
}
