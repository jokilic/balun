import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/sections/league_section.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/balun_button.dart';

class LeagueSectionTitles extends StatelessWidget {
  final LeagueSection activeLeagueSection;
  final Function(LeagueSection pressedSection) titlePressed;

  const LeagueSectionTitles({
    required this.activeLeagueSection,
    required this.titlePressed,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 70,
        child: ListView.separated(
          key: const PageStorageKey('leagueSectionTitles'),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: LeagueSectionEnum.values.length,
          itemBuilder: (context, index) {
            final section = LeagueSection(
              leagueSectionEnum: LeagueSectionEnum.values[index],
            );

            return BalunButton(
              onPressed: () => titlePressed(section),
              child: AnimatedContainer(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                duration: BalunConstants.animationDuration,
                curve: Curves.easeIn,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: activeLeagueSection == section ? context.colors.black : context.colors.black.withOpacity(0.075),
                ),
                child: Text(
                  section.getLeagueSectionName(),
                  style: context.textStyles.matchSectionTitle.copyWith(
                    color: activeLeagueSection == section ? context.colors.white : context.colors.black,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 12),
        ),
      );
}
