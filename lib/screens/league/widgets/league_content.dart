import 'package:flutter/material.dart';

import '../../../util/state.dart';
import '../../../widgets/balun_error.dart';
import '../../../widgets/balun_loader.dart';
import 'league_success.dart';

class LeagueContent extends StatelessWidget {
  final BalunState leagueState;

  const LeagueContent({
    required this.leagueState,
  });

  @override
  Widget build(BuildContext context) => switch (leagueState) {
        Initial() => Container(color: Colors.green),
        Loading() => const Center(child: BalunLoader()),
        Empty() => Container(color: Colors.grey),
        Error() => BalunError(
            error: (leagueState as Error).error ?? 'Generic league error',
          ),
        Success() => LeagueSuccess(
            league: (leagueState as Success).data,
          ),
      };
}
