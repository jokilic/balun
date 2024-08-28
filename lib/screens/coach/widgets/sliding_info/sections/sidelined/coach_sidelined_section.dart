import 'package:flutter/material.dart';

import '../../../../../../widgets/balun_error.dart';

// TODO: Implement this
class CoachSidelinedSection extends StatelessWidget {
  final int? coachId;

  const CoachSidelinedSection({
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
              error: 'Sidelined is still under construction',
              verticalPadding: 0,
            ),
          ],
        ),
      );
}
