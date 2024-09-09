import 'package:flutter/material.dart';

import '../../../util/state.dart';
import '../../../widgets/balun_empty.dart';
import '../../../widgets/balun_error.dart';
import 'leagues_loading.dart';
import 'leagues_success.dart';

class LeaguesContent extends StatelessWidget {
  final BalunState leaguesState;

  const LeaguesContent({
    required this.leaguesState,
  });

  @override
  Widget build(BuildContext context) => switch (leaguesState) {
        Initial() => const BalunError(
            error: "Initial state, this shouldn't happen",
          ),
        Loading() => LeaguesLoading(),
        Empty() => const BalunEmpty(
            message: 'There are no leagues',
          ),
        Error() => BalunError(
            error: (leaguesState as Error).error ?? 'Generic leagues error',
          ),
        Success() => LeaguesSuccess(
            leagues: (leaguesState as Success).data,
          ),
      };
}
