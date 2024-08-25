import 'package:flutter/material.dart';

import '../../../../models/coach_section.dart';
import '../../../../models/coaches/coach_response.dart';

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
          Container(
            height: 100,
            color: Colors.blue,
          ),
        // CoachInfoSection(
        //   coach: coach,
        // ),
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
