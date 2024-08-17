import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/player_section.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/balun_button.dart';

class PlayerSectionTitles extends StatelessWidget {
  final PlayerSection activePlayerSection;
  final Function(PlayerSection pressedSection) titlePressed;

  const PlayerSectionTitles({
    required this.activePlayerSection,
    required this.titlePressed,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 70,
        child: ListView.separated(
          key: const PageStorageKey('playerSectionTitles'),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: PlayerSectionEnum.values.length,
          itemBuilder: (context, index) {
            final section = PlayerSection(
              playerSectionEnum: PlayerSectionEnum.values[index],
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
                  color: activePlayerSection == section ? context.colors.black : context.colors.black.withOpacity(0.075),
                ),
                child: Text(
                  section.getPlayerSectionName(),
                  style: context.textStyles.matchSectionTitle.copyWith(
                    color: activePlayerSection == section ? context.colors.white : context.colors.black,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 12),
        ),
      );
}
