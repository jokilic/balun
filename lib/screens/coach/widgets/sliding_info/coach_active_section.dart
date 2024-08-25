import 'package:flutter/material.dart';

import '../../../../models/coach_section.dart';
import '../../../../models/coaches/coach_response.dart';
import 'sections/career/coach_career_section.dart';
import 'sections/info/coach_info_section.dart';
import 'sections/sidelined/coach_sidelined_section.dart';
import 'sections/trophies/coach_trophies_section.dart';

class CoachActiveSection extends StatelessWidget {
  final CoachResponse coach;
  final CoachSection coachSection;

  const CoachActiveSection({
    required this.coach,
    required this.coachSection,
  });

  @override
  Widget build(BuildContext context) => switch (coachSection) {
        CoachSection(
          coachSectionEnum: CoachSectionEnum.info,
        ) =>
          CoachInfoSection(
            coach: coach,
          ),
        CoachSection(
          coachSectionEnum: CoachSectionEnum.career,
        ) =>
          CoachCareerSection(
            careers: coach.career,
          ),
        CoachSection(
          coachSectionEnum: CoachSectionEnum.sidelined,
        ) =>
          CoachSidelinedSection(
            coachId: coach.id,
          ),
        CoachSection(
          coachSectionEnum: CoachSectionEnum.trophies,
        ) =>
          CoachTrophiesSection(
            coachId: coach.id,
          ),
      };
}
