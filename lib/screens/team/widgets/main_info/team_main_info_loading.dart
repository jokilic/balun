import 'package:flutter/material.dart';

import '../../../../theme/icons.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/balun_button.dart';

class TeamMainInfoLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                BalunButton(
                  onPressed: Navigator.of(context).pop,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colors.white.withOpacity(0.4),
                    ),
                    child: Image.asset(
                      BalunIcons.back,
                      height: 32,
                      width: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 24,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: context.colors.black.withOpacity(0.25),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 16,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: context.colors.black.withOpacity(0.15),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                height: 120,
                width: 120,
                color: context.colors.white.withOpacity(0.25),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.colors.black.withOpacity(0.25),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 24,
              width: 96,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.colors.black.withOpacity(0.15),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 16,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.colors.black.withOpacity(0.15),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 24,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.colors.black.withOpacity(0.25),
              ),
            ),
          ],
        ),
      );
}
