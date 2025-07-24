import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/random.dart';

class LeagueFixturesLoading extends StatelessWidget {
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
    child: ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
      physics: const BouncingScrollPhysics(),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 32,
            width: getRandomNumberFromBase(144),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.colors.primaryForeground.withValues(alpha: 0.15),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(
          8,
          (index) => Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 8,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 16,
            ),
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(
                color: context.colors.primaryForeground,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.colors.primaryForeground.withValues(alpha: 0.15),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
