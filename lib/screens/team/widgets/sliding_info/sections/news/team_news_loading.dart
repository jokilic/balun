import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/color.dart';
import '../../../../../../util/random.dart';
import '../../../../../../widgets/balun_seperator.dart';

class TeamNewsLoading extends StatelessWidget {
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
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 12,
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: getRandomBalunColor(context),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 24,
                          width: getRandomNumberFromBase(184),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.colors.black.withValues(alpha: 0.5),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 24,
                          width: getRandomNumberFromBase(184),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.colors.black.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          height: 8,
                          width: getRandomNumberFromBase(24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.colors.black.withValues(alpha: 0.15),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: getRandomBalunColor(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  height: 16,
                  width: getRandomNumberFromBase(320),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.colors.black.withValues(alpha: 0.25),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 16,
                  width: getRandomNumberFromBase(320),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.colors.black.withValues(alpha: 0.25),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 16,
                  width: getRandomNumberFromBase(320),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.colors.black.withValues(alpha: 0.25),
                  ),
                ),
              ],
            ),
          ),
          separatorBuilder: (_, __) => const BalunSeperator(),
        ),
      );
}
