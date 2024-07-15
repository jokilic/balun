import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../widgets/balun_loader.dart';
import '../team_state.dart';
import 'team_success.dart';

class TeamContent extends StatelessWidget {
  final TeamState teamState;

  const TeamContent({
    required this.teamState,
  });

  @override
  Widget build(BuildContext context) => switch (teamState) {
        TeamStateInitial() => Container(color: Colors.green),
        TeamStateLoading() => Center(child: BalunLoader()),
        TeamStateEmpty() => Container(color: Colors.grey),
        TeamStateError() => Container(
            color: Colors.red,
            child: Center(
              child: Text(
                (teamState as TeamStateError).error ?? 'Generic Team error',
                style: context.textStyles.fixturesName,
              ),
            ),
          ),
        TeamStateSuccess() => TeamSuccess(
            team: (teamState as TeamStateSuccess).team,
          ),
      };
}
