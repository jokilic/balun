import 'package:flutter/material.dart';

import '../../../../../../widgets/balun_error.dart';

// TODO: Implement this
class CoachTrophiesSection extends StatelessWidget {
  final int? coachId;

  const CoachTrophiesSection({
    required this.coachId,
  });

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          children: [
            BalunError(
              error: 'Trophies is still under construction',
              verticalPadding: 8,
            ),
          ],
        ),
      );
}
