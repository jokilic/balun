import 'package:flutter/material.dart';

import '../../../util/state.dart';
import '../../../widgets/balun_empty.dart';
import '../../../widgets/balun_error.dart';
import 'coach_loading.dart';
import 'coach_success.dart';

class CoachContent extends StatelessWidget {
  final BalunState coachState;

  const CoachContent({
    required this.coachState,
  });

  @override
  Widget build(BuildContext context) => switch (coachState) {
        Initial() => const BalunError(
            error: "Initial state, this shouldn't happen",
          ),
        Loading() => CoachLoading(),
        Empty() => const BalunEmpty(
            message: 'There is no coach',
          ),
        Error() => BalunError(
            error: (coachState as Error).error ?? 'Generic coach error',
          ),
        Success() => CoachSuccess(
            coach: (coachState as Success).data,
          ),
      };
}
