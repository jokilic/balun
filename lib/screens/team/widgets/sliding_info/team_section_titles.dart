import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/sections/team_section.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/balun_button.dart';

class TeamSectionTitles extends StatelessWidget {
  final PageController pageController;
  final TeamSection activeTeamSection;
  final Function(TeamSection pressedSection) titlePressed;

  const TeamSectionTitles({
    required this.pageController,
    required this.activeTeamSection,
    required this.titlePressed,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 70,
    child: ListView.separated(
      controller: pageController,
      key: const PageStorageKey('teamSectionTitles'),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: TeamSectionEnum.values.length,
      itemBuilder: (context, index) {
        final section = TeamSection(
          teamSectionEnum: TeamSectionEnum.values[index],
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
              color: activeTeamSection == section ? context.colors.primaryForeground : context.colors.primaryForeground.withValues(alpha: 0.075),
            ),
            child: Text(
              section.getTeamSectionName(),
              style: context.textStyles.bodyLg.copyWith(
                color: activeTeamSection == section ? context.colors.primaryBackground : context.colors.primaryForeground,
              ),
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(width: 12),
    ),
  );
}
