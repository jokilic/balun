import 'package:flutter/material.dart';

import '../../../../models/coach_section.dart';
import '../../../../models/coaches/coach_response.dart';
import 'sections/career/coach_career_section.dart';
import 'sections/info/coach_info_section.dart';

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
            career: coach.career,
          ),
        CoachSection(
          coachSectionEnum: CoachSectionEnum.sidelined,
        ) =>
          Container(
            height: 100,
            color: Colors.green,
          ),
        // CoachSidelinedSection(
        //   coachId: coach.id,
        // ),
        CoachSection(
          coachSectionEnum: CoachSectionEnum.trophies,
        ) =>
          Container(
            height: 100,
            color: Colors.deepPurple,
          ),
        // CoachTrophiesSection(
        //   coachId: coach.id,
        // ),
      };
}
