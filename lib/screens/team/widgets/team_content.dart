import 'package:flutter/material.dart';

import '../../../util/state.dart';
import '../../../widgets/balun_error.dart';
import '../../../widgets/balun_loader.dart';
import 'team_success.dart';

class TeamContent extends StatelessWidget {
  final BalunState teamState;

  const TeamContent({
    required this.teamState,
  });

// TODO: Implement all states
  @override
  Widget build(BuildContext context) => switch (teamState) {
        Initial() => Container(color: Colors.green),
        Loading() => const Center(child: BalunLoader()),
        Empty() => Container(color: Colors.grey),
        Error() => BalunError(
            error: (teamState as Error).error ?? 'Generic Team error',
          ),
        Success() => TeamSuccess(
            team: (teamState as Success).data,
          ),
      };
}
