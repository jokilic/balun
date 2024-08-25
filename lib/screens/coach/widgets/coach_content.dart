import 'package:flutter/material.dart';

import '../../../util/state.dart';
import '../../../widgets/balun_error.dart';
import '../../../widgets/balun_loader.dart';
import 'coach_success.dart';

class CoachContent extends StatelessWidget {
  final BalunState coachState;

  const CoachContent({
    required this.coachState,
  });

  @override
  Widget build(BuildContext context) => switch (coachState) {
        Initial() => Container(color: Colors.green),
        Loading() => const Center(child: BalunLoader()),
        Empty() => Container(color: Colors.grey),
        Error() => BalunError(
            error: (coachState as Error).error ?? 'Generic coach error',
          ),
        Success() => CoachSuccess(
            coach: (coachState as Success).data,
          ),
      };
}
