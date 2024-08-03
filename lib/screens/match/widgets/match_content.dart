import 'package:flutter/material.dart';

import '../../../util/state.dart';
import '../../../widgets/balun_error.dart';
import '../../../widgets/balun_loader.dart';
import 'match_success.dart';

class MatchContent extends StatelessWidget {
  final BalunState matchState;

  const MatchContent({
    required this.matchState,
  });

// TODO: Implement all states
  @override
  Widget build(BuildContext context) => switch (matchState) {
        Initial() => Container(color: Colors.green),
        Loading() => const Center(child: BalunLoader()),
        Empty() => Container(color: Colors.grey),
        Error() => BalunError(
            error: (matchState as Error).error ?? 'Generic match error',
          ),
        Success() => MatchSuccess(
            match: (matchState as Success).data,
          ),
      };
}
