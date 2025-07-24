import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../constants.dart';
import '../../../../../theme/theme.dart';
import '../../../../../util/color.dart';
import '../../../../../util/random.dart';

class SearchLeaguesLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Animate(
    onPlay: (controller) => controller.loop(
      reverse: true,
      min: 0.6,
    ),
    effects: const [
      FadeEffect(
        curve: Curves.easeIn,
        duration: BalunConstants.shimmerDuration,
      ),
    ],
    child: ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: 12,
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: getRandomBalunColor(context),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  width: getRandomNumberFromBase(160),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.colors.primaryForeground.withValues(alpha: 0.25),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: getRandomNumberFromBase(80),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.colors.primaryForeground.withValues(alpha: 0.15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 4),
    ),
  );
}
