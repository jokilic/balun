import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';
import '../../../../util/random.dart';

class LeagueSlidingInfoLoading extends StatelessWidget {
  final ScrollController scrollController;

  const LeagueSlidingInfoLoading({
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) => ListView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: context.colors.black.withOpacity(0.5),
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
                  color: index == 1 ? context.colors.black : context.colors.black.withOpacity(0.075),
                ),
                child: Container(
                  height: 24,
                  width: getRandomNumberFromBase(104),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: index == 1 ? context.colors.white.withOpacity(0.8) : context.colors.black.withOpacity(0.25),
                  ),
                ),
              ),
              separatorBuilder: (_, __) => const SizedBox(width: 12),
            ),
          ),
          const SizedBox(height: 24),
          ListView(
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
                    color: context.colors.black.withOpacity(0.15),
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
                      color: context.colors.black,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: context.colors.black.withOpacity(0.15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}
