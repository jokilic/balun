import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/color.dart';
import '../../../../../../util/random.dart';

class TeamMatchesLoading extends StatelessWidget {
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
          (index) => Column(
            children: [
              Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: context.colors.primaryForeground,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        Container(
                          height: 12,
                          width: getRandomNumberFromBase(80),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.colors.primaryForeground.withValues(alpha: 0.15),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 12,
                          width: getRandomNumberFromBase(104),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.colors.primaryForeground.withValues(alpha: 0.25),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ///
                        /// HOME
                        ///
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Container(
                                  height: 16,
                                  width: getRandomNumberFromBase(104),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: context.colors.primaryForeground.withValues(alpha: 0.25),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: getRandomBalunColor(context),
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///
                        /// SCORE
                        ///
                        const SizedBox(width: 12),
                        Container(
                          height: 16,
                          width: getRandomNumberFromBase(24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.colors.primaryForeground.withValues(alpha: 0.25),
                          ),
                        ),
                        const SizedBox(width: 12),

                        ///
                        /// AWAY
                        ///
                        Expanded(
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
                              const SizedBox(width: 8),
                              Flexible(
                                child: Container(
                                  height: 16,
                                  width: getRandomNumberFromBase(104),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: context.colors.primaryForeground.withValues(alpha: 0.25),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    ),
  );
}
