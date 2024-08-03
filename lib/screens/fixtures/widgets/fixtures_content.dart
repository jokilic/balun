import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../util/state.dart';
import '../../../widgets/balun_loader.dart';
import 'fixtures_success.dart';

class FixturesContent extends StatelessWidget {
  final BalunState fixturesState;

  const FixturesContent({
    required this.fixturesState,
  });

// TODO: Implement all states
  @override
  Widget build(BuildContext context) => switch (fixturesState) {
        Initial() => Container(color: Colors.green),
        Loading() => const Center(child: BalunLoader()),
        Empty() => Container(color: Colors.grey),
        Error() => Container(
            color: Colors.red,
            child: Center(
              child: Text(
                (fixturesState as Error).error ?? 'Generic fixtures error',
                style: context.textStyles.fixturesName,
              ),
            ),
          ),
        Success() => FixturesSuccess(
            fixtures: (fixturesState as Success).data,
          ),
      };
}
