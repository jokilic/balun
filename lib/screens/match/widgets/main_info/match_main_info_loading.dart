import 'package:flutter/material.dart';

import '../../../../theme/icons.dart';
import '../../../../theme/theme.dart';
import '../../../../util/color.dart';
import '../../../../util/random.dart';
import '../../../../widgets/balun_button.dart';
import '../../../../widgets/balun_image.dart';

class MatchMainInfoLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
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
                      color: context.colors.white.withValues(alpha: 0.4),
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
                          color: context.colors.black.withValues(alpha: 0.25),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 16,
                        width: getRandomNumberFromBase(80),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: context.colors.black.withValues(alpha: 0.15),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: getRandomBalunColor(context),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 24,
                        width: getRandomNumberFromBase(80),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: context.colors.black.withValues(alpha: 0.25),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: context.colors.black.withValues(alpha: 0.2),
                            width: 1.5,
                          ),
                        ),
                        child: Container(
                          height: 28,
                          width: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.colors.black.withValues(alpha: 0.15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: getRandomBalunColor(context),
                        ),
                      ),

                      const SizedBox(height: 16),

                      ///
                      /// HOME NAME
                      ///
                      Container(
                        height: 24,
                        width: getRandomNumberFromBase(80),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: context.colors.black.withValues(alpha: 0.25),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///
                /// HOME SCORERS
                ///
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      ...List.generate(
                        2,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: context.colors.black.withValues(alpha: 0.15),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Container(
                                  height: 16,
                                  width: getRandomNumberFromBase(80),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: context.colors.black.withValues(alpha: 0.25),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ///
                /// SCORE
                ///
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: context.colors.black.withValues(alpha: 0.5),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        ':',
                        style: context.textStyles.fixturesScore.copyWith(
                          color: context.colors.black.withValues(alpha: 0.2),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: context.colors.black.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),

                ///
                /// AWAY SCORERS
                ///
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      ...List.generate(
                        2,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                  height: 16,
                                  width: getRandomNumberFromBase(80),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: context.colors.black.withValues(alpha: 0.25),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: context.colors.black.withValues(alpha: 0.15),
                                ),
                              ),
                            ],
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
      );
}
