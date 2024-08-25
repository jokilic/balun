import 'package:flutter/material.dart';

import '../../../../../../models/coaches/career/career.dart';
import 'coach_career_list_tile.dart';

class CoachCareerSection extends StatelessWidget {
  final List<Career>? careers;

  const CoachCareerSection({
    required this.careers,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: careers?.length ?? 0,
        itemBuilder: (_, index) {
          final career = careers![index];

          return CoachCareerListTile(
            career: career,
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 8),
      );
}
