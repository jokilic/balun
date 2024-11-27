import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/color.dart';
import '../../../../../../util/random.dart';

class MatchHighlightsLoading extends StatelessWidget {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: getRandomBalunColor(context),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 32,
                  width: getRandomNumberFromBase(240),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: context.colors.black.withOpacity(0.25),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 32,
                  width: getRandomNumberFromBase(224),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: context.colors.black.withOpacity(0.25),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 16,
                    width: getRandomNumberFromBase(56),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: context.colors.black.withOpacity(0.15),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 20,
                  width: getRandomNumberFromBase(240),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: context.colors.black.withOpacity(0.15),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 20,
                  width: getRandomNumberFromBase(240),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: context.colors.black.withOpacity(0.15),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 20,
                  width: getRandomNumberFromBase(240),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: context.colors.black.withOpacity(0.15),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 40,
                  width: getRandomNumberFromBase(144),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: context.colors.black.withOpacity(0.25),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ///
              /// VIDEOS
              ///
              ...List.generate(
                5,
                (index) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: index == 0 ? context.colors.green : Colors.transparent,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 80,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: getRandomBalunColor(context),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 24,
                              width: getRandomNumberFromBase(184),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: context.colors.black.withOpacity(0.25),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 24,
                              width: getRandomNumberFromBase(160),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: context.colors.black.withOpacity(0.25),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 16,
                              width: getRandomNumberFromBase(56),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: context.colors.black.withOpacity(0.15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
