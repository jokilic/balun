import 'package:flutter/material.dart';

import '../../../util/state.dart';
import '../../../widgets/balun_error.dart';
import '../../../widgets/balun_loader.dart';
import 'leagues_success.dart';

class LeaguesContent extends StatelessWidget {
  final BalunState leaguesState;

  const LeaguesContent({
    required this.leaguesState,
  });

// TODO: Implement all states
  @override
  Widget build(BuildContext context) => switch (leaguesState) {
        Initial() => Container(color: Colors.green),
        Loading() => const Center(child: BalunLoader()),
        Empty() => Container(color: Colors.grey),
        Error() => BalunError(
            error: (leaguesState as Error).error ?? 'Generic leagues error',
          ),
        Success() => LeaguesSuccess(
            leagues: (leaguesState as Success).data,
          ),
      };
}
