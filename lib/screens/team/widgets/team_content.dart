import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../util/state.dart';
import '../../../widgets/balun_loader.dart';
import 'team_success.dart';

class TeamContent extends StatelessWidget {
  final BalunState teamState;

  const TeamContent({
    required this.teamState,
  });

  @override
  Widget build(BuildContext context) => switch (teamState) {
        Initial() => Container(color: Colors.green),
        Loading() => Center(child: BalunLoader()),
        Empty() => Container(color: Colors.grey),
        Error() => Container(
            color: Colors.red,
            child: Center(
              child: Text(
                (teamState as Error).error ?? 'Generic Team error',
                style: context.textStyles.fixturesName,
              ),
            ),
          ),
        Success() => TeamSuccess(
            team: (teamState as Success).data,
          ),
      };
}
