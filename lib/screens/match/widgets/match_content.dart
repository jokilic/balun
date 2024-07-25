import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../util/state.dart';
import '../../../widgets/balun_loader.dart';
import 'match_success.dart';

class MatchContent extends StatelessWidget {
  final BalunState matchState;

  const MatchContent({
    required this.matchState,
  });

  @override
  Widget build(BuildContext context) => switch (matchState) {
        Initial() => Container(color: Colors.green),
        Loading() => Center(child: BalunLoader()),
        Empty() => Container(color: Colors.grey),
        Error() => Container(
            color: Colors.red,
            child: Center(
              child: Text(
                (matchState as Error).error ?? 'Generic match error',
                style: context.textStyles.fixturesName,
              ),
            ),
          ),
        Success() => MatchSuccess(
            match: (matchState as Success).data,
          ),
      };
}
