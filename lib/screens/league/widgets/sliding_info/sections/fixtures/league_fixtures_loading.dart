import 'package:flutter/material.dart';

import '../../../../../../theme/theme.dart';

class LeagueFixturesLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        physics: const BouncingScrollPhysics(),
        children: List.generate(
          8,
          (index) => Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 12,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 16,
            ),
            height: 64,
            decoration: BoxDecoration(
              border: Border.all(
                color: context.colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
              color: context.colors.black.withOpacity(0.075),
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
      );
}
