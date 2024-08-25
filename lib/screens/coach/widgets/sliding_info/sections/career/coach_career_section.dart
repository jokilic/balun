import 'package:flutter/material.dart';

import '../../../../../../models/coaches/career/career.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'coach_career_list_tile.dart';

class CoachCareerSection extends StatelessWidget {
  final List<Career>? career;

  const CoachCareerSection({
    required this.career,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: career?.length ?? 0,
        itemBuilder: (_, index) {
          final careerValue = career![index];

          return CoachCareerListTile(
            careerValue: careerValue,
          );
        },
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
