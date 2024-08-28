import 'package:flutter/material.dart';

import '../../../util/state.dart';
import '../../../widgets/balun_empty.dart';
import '../../../widgets/balun_error.dart';
import 'team_loading.dart';
import 'team_success.dart';

class TeamContent extends StatelessWidget {
  final BalunState teamState;

  const TeamContent({
    required this.teamState,
  });

  @override
  Widget build(BuildContext context) => switch (teamState) {
        Initial() => const BalunEmpty(
            message: "Initial state, this shouldn't happen",
          ),
        Loading() => TeamLoading(),
        Empty() => const BalunEmpty(
            message: 'There is no team',
          ),
        Error() => BalunError(
            error: (teamState as Error).error ?? 'Generic team error',
          ),
        Success() => TeamSuccess(
            team: (teamState as Success).data,
          ),
      };
}
