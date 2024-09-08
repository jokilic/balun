import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';

class FixturesListTileMinute extends StatelessWidget {
  final String status;
  final String? timeBeforeMatch;

  const FixturesListTileMinute({
    required this.status,
    required this.timeBeforeMatch,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: context.colors.greenish,
            width: 1.5,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            if (timeBeforeMatch != null)
              Text(
                timeBeforeMatch!,
                style: context.textStyles.fixturesMinute,
                textAlign: TextAlign.center,
              )
            else
              Text(
                status,
                style: context.textStyles.fixturesMinute,
                textAlign: TextAlign.center,
              ),
            if (int.tryParse(status) != null)
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
