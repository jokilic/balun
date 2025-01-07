import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/sections/match_section.dart';
import '../../../../services/remote_settings_service.dart';
import '../../../../theme/theme.dart';
import '../../../../util/dependencies.dart';
import '../../../../widgets/balun_button.dart';

class MatchSectionTitles extends StatelessWidget {
  final MatchSection activeMatchSection;
  final Function(MatchSection pressedSection) titlePressed;
  final bool matchFinished;

  const MatchSectionTitles({
    required this.activeMatchSection,
    required this.titlePressed,
    required this.matchFinished,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 70,
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

            /// Hide [Highlights] section if:
            /// a) Match is not finished
            /// b) Remote value `hideHighlights` is enabled
            /// c) Running on `web`
            if ((!matchFinished || getIt.get<RemoteSettingsService>().value.hideHighlights || kIsWeb) &&
                section ==
                    MatchSection(
                      matchSectionEnum: MatchSectionEnum.highlights,
                    )) {
              return const SizedBox.shrink();
            }

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
                  color: activeMatchSection == section ? context.colors.black : context.colors.black.withValues(alpha: 0.075),
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
          separatorBuilder: (_, index) {
            final section = MatchSection(
              matchSectionEnum: MatchSectionEnum.values[index],
            );

            /// Hide [Highlights] spacing if:
            /// a) Match is not finished
            /// b) Remote value `hideHighlights` is enabled
            /// c) Running on `web`
            if ((!matchFinished || getIt.get<RemoteSettingsService>().value.hideHighlights || kIsWeb) &&
                section ==
                    MatchSection(
                      matchSectionEnum: MatchSectionEnum.highlights,
                    )) {
              return const SizedBox.shrink();
            }

            return const SizedBox(width: 12);
          },
        ),
      );
}
