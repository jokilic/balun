import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../widgets/balun_loader.dart';
import '../fixtures_state.dart';
import 'fixtures_success.dart';

class FixturesContent extends StatelessWidget {
  final FixturesState fixturesState;

  const FixturesContent({
    required this.fixturesState,
  });

  @override
  Widget build(BuildContext context) => switch (fixturesState) {
        FixturesStateInitial() => Container(color: Colors.green),
        FixturesStateLoading() => Center(child: BalunLoader()),
        FixturesStateEmpty() => Container(color: Colors.grey),
        FixturesStateError() => Container(
            color: Colors.red,
            child: Center(
              child: Text(
                (fixturesState as FixturesStateError).error ?? 'Generic fixtures error',
                style: context.textStyles.fixturesName,
              ),
            ),
          ),
        FixturesStateSuccess() => FixturesSuccess(
            fixtures: (fixturesState as FixturesStateSuccess).fixtures,
          ),
      };
}
