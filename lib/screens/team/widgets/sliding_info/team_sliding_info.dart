import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../constants.dart';
import '../../../../models/teams/team_response.dart';
import '../../../../theme/theme.dart';
import '../../../../util/dependencies.dart';
import '../../controllers/team_season_controller.dart';
import '../../controllers/team_section_controller.dart';
import 'team_active_section.dart';
import 'team_section_titles.dart';

class TeamSlidingInfo extends WatchingWidget {
  final TeamResponse team;
  final ScrollController scrollController;

  const TeamSlidingInfo({
    required this.team,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final teamSection = watchIt<TeamSectionController>(
      instanceName: '${team.team?.id}',
    ).value;

    final teamSeason = watchIt<TeamSeasonController>(
      instanceName: '${team.team?.id}',
    ).value;

    return ListView(
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

        ///
        /// SECTIONS
        ///
        TeamSectionTitles(
          activeTeamSection: teamSection,
          titlePressed: getIt
              .get<TeamSectionController>(
                instanceName: '${team.team?.id}',
              )
              .updateState,
        ),

        const SizedBox(height: 24),

        ///
        /// ACTIVE SECTION
        ///
        Animate(
          key: ValueKey(teamSection),
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: BalunConstants.animationDuration,
            ),
          ],
          child: TeamActiveSection(
            team: team,
            teamSection: teamSection,
            activeSeason: teamSeason,
          ),
        ),
      ],
    );
  }
}
