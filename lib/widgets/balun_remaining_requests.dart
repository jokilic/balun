import 'package:flutter/material.dart';

import '../theme/theme.dart';

class BalunRemainingRequests extends StatelessWidget {
  final int? remainingRequests;

  const BalunRemainingRequests({
    required this.remainingRequests,
  });

  Color getBackgroundColor({
    required int? remainingRequests,
    required BuildContext context,
  }) {
    if (remainingRequests == null) {
      return Colors.transparent;
    }

    if (remainingRequests >= 80) {
      return context.colors.green;
    }

    if (remainingRequests < 80 && remainingRequests >= 50) {
      return context.colors.yellow;
    }

    if (remainingRequests < 50 && remainingRequests >= 20) {
      return context.colors.orange;
    }

    if (remainingRequests < 20) {
      return context.colors.red;
    }

    return context.colors.blue;
  }

  @override
  Widget build(BuildContext context) => IgnorePointer(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 80,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: getBackgroundColor(
                remainingRequests: remainingRequests,
                context: context,
              ),
            ),
            child: Column(
              children: [
                Text(
                  '$remainingRequests',
                  style: TextStyle(
                    fontFamily: 'Lufga',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: context.colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                Text(
                  'Remaining requests',
                  style: TextStyle(
                    fontFamily: 'Lufga',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: context.colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
}
