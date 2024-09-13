import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

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
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 176,
              vertical: 8,
            ),
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: context.colors.black.withOpacity(0.5),
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
                  color: index == 0 ? context.colors.black : context.colors.black.withOpacity(0.075),
                ),
                child: Container(
                  height: 24,
                  width: 104,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: index == 0 ? context.colors.white.withOpacity(0.8) : context.colors.black.withOpacity(0.25),
                  ),
                ),
              ),
              separatorBuilder: (_, __) => const SizedBox(width: 12),
            ),
          ),
          const SizedBox(height: 24),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 12,
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: context.colors.black.withOpacity(0.25),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 24,
                          width: 184,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.colors.black.withOpacity(0.25),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 16,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.colors.black.withOpacity(0.15),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 14,
                          width: 104,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.colors.black.withOpacity(0.25),
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
      );
}
