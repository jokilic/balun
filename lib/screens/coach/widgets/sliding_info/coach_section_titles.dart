import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/sections/coach_section.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/balun_button.dart';

class CoachSectionTitles extends StatelessWidget {
  final CoachSection activeCoachSection;
  final Function(CoachSection pressedSection) titlePressed;

  const CoachSectionTitles({
    required this.activeCoachSection,
    required this.titlePressed,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 70,
        child: ListView.separated(
          key: const PageStorageKey('coachSectionTitles'),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: CoachSectionEnum.values.length,
          itemBuilder: (context, index) {
            final section = CoachSection(
              coachSectionEnum: CoachSectionEnum.values[index],
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
                  color: activeCoachSection == section ? context.colors.black : context.colors.black.withValues(alpha: 0.075),
                ),
                child: Text(
                  section.getCoachSectionName(),
                  style: context.textStyles.matchSectionTitle.copyWith(
                    color: activeCoachSection == section ? context.colors.white : context.colors.black,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 12),
        ),
      );
}
