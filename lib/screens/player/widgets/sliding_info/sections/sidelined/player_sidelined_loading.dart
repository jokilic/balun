import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/random.dart';
import '../../../../../../widgets/balun_image.dart';
import '../../../../../../widgets/balun_seperator.dart';

class PlayerSidelinedLoading extends StatelessWidget {
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
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///
                /// TYPE
                ///
                Container(
                  height: 24,
                  width: getRandomNumberFromBase(200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.colors.black.withValues(alpha: 0.5),
                  ),
                ),
                const SizedBox(height: 8),

                ///
                /// START
                ///
                Row(
                  children: [
                    BalunImage(
                      imageUrl: BalunIcons.playerOut,
                      height: 28,
                      width: 28,
                      color: context.colors.red,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 16,
                      width: getRandomNumberFromBase(200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: context.colors.black.withValues(alpha: 0.15),
                      ),
                    ),
                  ],
                ),

                ///
                /// END
                ///
                Row(
                  children: [
                    BalunImage(
                      imageUrl: BalunIcons.playerIn,
                      height: 28,
                      width: 28,
                      color: context.colors.green,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 16,
                      width: getRandomNumberFromBase(200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: context.colors.black.withValues(alpha: 0.15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          separatorBuilder: (_, __) => const BalunSeperator(),
        ),
      );
}
