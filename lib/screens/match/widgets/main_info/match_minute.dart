import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class MatchMinute extends StatelessWidget {
  final ({int minutes, int? extra})? minutes;
  final String? textStatus;
  final String? timeBeforeMatch;

  const MatchMinute({
    required this.minutes,
    required this.textStatus,
    required this.timeBeforeMatch,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
    decoration: BoxDecoration(
      color: context.colors.primaryBackgroundLight,
      borderRadius: BorderRadius.circular(100),
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
            style: context.textStyles.titleMdBoldTight,
            textAlign: TextAlign.center,
          )
        ///
        /// STATUS
        ///
        else if (textStatus != null)
          Text(
            textStatus!.toUpperCase(),
            style: context.textStyles.titleMdBoldTight,
            textAlign: TextAlign.center,
          )
        ///
        /// MINUTES (IF THERE'S NO EXTRA)
        ///
        else if (minutes != null && minutes?.extra == null) ...[
          Text(
            minutes!.minutes.toString(),
            style: context.textStyles.titleMdBoldTight,
            textAlign: TextAlign.center,
          ),
          Positioned(
            right: -6,
            child: Text(
              "'",
              style: context.textStyles.titleMdBoldTight,
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
                style: context.textStyles.titleMdBoldTight,
                textAlign: TextAlign.center,
              ),
              Text(
                "'",
                style: context.textStyles.titleMdBoldTight,
                textAlign: TextAlign.center,
              ),
              const SizedBox(width: 2),
              Text(
                '+${minutes!.extra}',
                style: context.textStyles.labelMuted,
              ),
            ],
          ),
      ],
    ),
  );
}
