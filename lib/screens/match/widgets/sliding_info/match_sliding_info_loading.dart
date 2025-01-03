import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../theme/theme.dart';
import '../../../../util/color.dart';
import '../../../../util/random.dart';

class MatchSlidingInfoLoading extends WatchingWidget {
  final ScrollController scrollController;

  const MatchSlidingInfoLoading({
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) => ListView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        children: [
          ///
          /// BLACK LINE
          ///
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: context.colors.black.withValues(alpha: 0.5),
              ),
            ),
          ),

          const SizedBox(height: 8),

          SizedBox(
            height: 70,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 12,
              itemBuilder: (_, index) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: index == 1 ? context.colors.black : context.colors.black.withValues(alpha: 0.075),
                ),
                child: Container(
                  height: 24,
                  width: getRandomNumberFromBase(104),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: index == 1 ? context.colors.white.withValues(alpha: 0.8) : context.colors.black.withValues(alpha: 0.25),
                  ),
                ),
              ),
              separatorBuilder: (_, __) => const SizedBox(width: 12),
            ),
          ),
          const SizedBox(height: 24),
          ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 12,
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: index.isOdd ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  if (index.isEven) ...[
                    Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: context.colors.black.withValues(alpha: 0.15),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: context.colors.black.withValues(alpha: 0.075),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: getRandomBalunColor(context),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Container(
                            height: 24,
                            width: getRandomNumberFromBase(144),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: context.colors.black.withValues(alpha: 0.25),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (index.isOdd) ...[
                    const SizedBox(width: 8),
                    Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: context.colors.black.withValues(alpha: 0.15),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      );
}
