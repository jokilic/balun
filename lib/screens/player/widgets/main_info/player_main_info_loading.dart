import 'package:flutter/material.dart';

import '../../../../theme/icons.dart';
import '../../../../theme/theme.dart';
import '../../../../util/color.dart';
import '../../../../util/random.dart';
import '../../../../widgets/balun_button.dart';
import '../../../../widgets/balun_image/balun_image.dart';

class PlayerMainInfoLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            BalunButton(
              onPressed: Navigator.of(context).pop,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.primaryBackground.withValues(alpha: 0.4),
                ),
                child: const BalunImage(
                  imageUrl: BalunIcons.back,
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
                    width: getRandomNumberFromBase(120),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: context.colors.primaryForeground.withValues(alpha: 0.25),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 16,
                    width: getRandomNumberFromBase(80),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: context.colors.primaryForeground.withValues(alpha: 0.15),
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
            color: context.colors.primaryBackground.withValues(alpha: 0.25),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 40,
          width: getRandomNumberFromBase(120),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.colors.primaryForeground.withValues(alpha: 0.25),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 24,
          width: getRandomNumberFromBase(96),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.colors.primaryForeground.withValues(alpha: 0.15),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: getRandomBalunColor(context),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 24,
              width: getRandomNumberFromBase(144),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.colors.primaryForeground.withValues(alpha: 0.25),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          height: 24,
          width: getRandomNumberFromBase(200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.colors.primaryForeground.withValues(alpha: 0.25),
          ),
        ),
      ],
    ),
  );
}
