import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';

class FixturesListTileMinute extends StatelessWidget {
  final ({int minutes, int? extra})? minutes;
  final String? textStatus;
  final String? timeBeforeMatch;

  const FixturesListTileMinute({
    required this.minutes,
    required this.textStatus,
    required this.timeBeforeMatch,
  });

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
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
            ///
            /// TIME
            ///
            if (timeBeforeMatch != null)
              Text(
                timeBeforeMatch!,
                style: context.textStyles.fixturesMinute,
                textAlign: TextAlign.center,
              )

            ///
            /// STATUS
            ///
            else if (textStatus != null)
              Text(
                textStatus!.toUpperCase(),
                style: context.textStyles.fixturesMinute,
                textAlign: TextAlign.center,
              )

            ///
            /// MINUTES (IF THERE'S NO EXTRA)
            ///
            else if (minutes != null && minutes?.extra == null) ...[
              Text(
                minutes!.minutes.toString(),
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
            ]

            ///
            /// MINUTES (WITH EXTRA)
            ///
            else if (minutes != null && minutes?.extra != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    minutes!.minutes.toString(),
                    style: context.textStyles.fixturesMinute,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "'",
                    style: context.textStyles.fixturesMinute,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '+${minutes!.extra}',
                    style: context.textStyles.fixturesMinuteExtra,
                  ),
                ],
              ),
          ],
        ),
      );
}
