import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../constants.dart';
import '../../../../models/coaches/coach_response.dart';
import '../../../../theme/theme.dart';
import '../../../../util/dependencies.dart';
import '../../controllers/coach_section_controller.dart';
import 'coach_active_section.dart';
import 'coach_section_titles.dart';

class CoachSlidingInfo extends WatchingWidget {
  final CoachResponse coach;
  final ScrollController scrollController;

  const CoachSlidingInfo({
    required this.coach,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final coachSection = watchIt<CoachSectionController>(
      instanceName: '${coach.id}',
    ).value;

    return ListView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      children: [
        ///
        /// BLACK LINE
        ///
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

        ///
        /// SECTIONS
        ///
        CoachSectionTitles(
          activeCoachSection: coachSection,
          titlePressed: getIt
              .get<CoachSectionController>(
                instanceName: '${coach.id}',
              )
              .updateState,
        ),

        const SizedBox(height: 24),

        ///
        /// ACTIVE SECTION
        ///
        Animate(
          key: ValueKey(coachSection),
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: BalunConstants.animationDuration,
            ),
          ],
          child: CoachActiveSection(
            coach: coach,
            coachSection: coachSection,
          ),
        ),
      ],
    );
  }
}
