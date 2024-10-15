import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/color.dart';
import '../../../../../../util/random.dart';

class MatchHead2HeadLoading extends StatelessWidget {
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
          physics: const BouncingScrollPhysics(),
          itemCount: 12,
          itemBuilder: (_, __) => Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.colors.black.withOpacity(0.075),
              border: Border.all(
                color: context.colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 16,
                          width: getRandomNumberFromBase(104),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.colors.black.withOpacity(0.25),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 12,
                          width: getRandomNumberFromBase(80),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.colors.black.withOpacity(0.15),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 16,
                          width: getRandomNumberFromBase(104),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.colors.black.withOpacity(0.25),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 12,
                          width: getRandomNumberFromBase(80),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.colors.black.withOpacity(0.15),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: getRandomBalunColor(context),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: context.colors.black.withOpacity(0.25),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      ':',
                      style: context.textStyles.matchH2HScore,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: context.colors.black.withOpacity(0.25),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: getRandomBalunColor(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          separatorBuilder: (_, __) => const SizedBox(height: 8),
        ),
      );
}
