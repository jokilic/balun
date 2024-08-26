import 'package:flutter/material.dart';

import '../../../util/state.dart';
import '../../../widgets/balun_empty.dart';
import '../../../widgets/balun_error.dart';
import 'league_loading.dart';
import 'league_success.dart';

class LeagueContent extends StatelessWidget {
  final BalunState leagueState;

  const LeagueContent({
    required this.leagueState,
  });

  @override
  Widget build(BuildContext context) => switch (leagueState) {
        Initial() => const BalunEmpty(
            message: "Initial state, this shouldn't happen",
          ),
        Loading() => LeagueLoading(),
        Empty() => const BalunEmpty(
            message: 'There are no league',
          ),
        Error() => BalunError(
            error: (leagueState as Error).error ?? 'Generic league error',
          ),
        Success() => LeagueSuccess(
            league: (leagueState as Success).data,
          ),
      };
}
