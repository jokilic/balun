import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/match_section.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/balun_button.dart';

class MatchSectionTitles extends StatelessWidget {
  final MatchSection activeMatchSection;
  final Function(MatchSection pressedSection) titlePressed;

  const MatchSectionTitles({
    required this.activeMatchSection,
    required this.titlePressed,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 76,
        child: ListView.separated(
          key: const PageStorageKey('matchSectionTitles'),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: MatchSectionEnum.values.length,
          itemBuilder: (context, index) {
            final section = MatchSection(
              matchSectionEnum: MatchSectionEnum.values[index],
            );

            return BalunButton(
              onPressed: () => titlePressed(section),
              child: AnimatedContainer(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                duration: BalunConstants.animationDuration,
                curve: Curves.easeIn,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: activeMatchSection == section ? context.colors.black : context.colors.black.withOpacity(0.075),
                ),
                child: Text(
                  section.getMatchSectionName(),
                  style: context.textStyles.matchSectionTitle.copyWith(
                    color: activeMatchSection == section ? context.colors.white : context.colors.black,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 12),
        ),
      );
}
