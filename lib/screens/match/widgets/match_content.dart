import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../widgets/balun_loader.dart';
import '../match_state.dart';
import 'match_success.dart';

class MatchContent extends StatelessWidget {
  final MatchState matchState;

  const MatchContent({
    required this.matchState,
  });

  @override
  Widget build(BuildContext context) => switch (matchState) {
        MatchStateInitial() => Container(color: Colors.green),
        MatchStateLoading() => Center(child: BalunLoader()),
        MatchStateEmpty() => Container(color: Colors.grey),
        MatchStateError() => Container(
            color: Colors.red,
            child: Center(
              child: Text(
                (matchState as MatchStateError).error ?? 'Generic match error',
                style: context.textStyles.fixturesName,
              ),
            ),
          ),
        MatchStateSuccess() => MatchSuccess(
            match: (matchState as MatchStateSuccess).match,
          ),
      };
}
