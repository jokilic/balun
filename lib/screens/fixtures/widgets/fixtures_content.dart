import 'package:flutter/material.dart';

import '../../../util/state.dart';
import '../../../widgets/balun_empty.dart';
import '../../../widgets/balun_error.dart';
import 'fixtures_loading.dart';
import 'fixtures_success.dart';

class FixturesContent extends StatelessWidget {
  final BalunState fixturesState;

  const FixturesContent({
    required this.fixturesState,
  });

  @override
  Widget build(BuildContext context) => switch (fixturesState) {
        Initial() => const BalunEmpty(
            message: "Initial state, this shouldn't happen",
          ),
        Loading() => FixturesLoading(),
        Empty() => const BalunEmpty(
            message: 'There are no fixtures',
          ),
        Error() => BalunError(
            error: (fixturesState as Error).error ?? 'Generic fixtures error',
          ),
        Success() => FixturesSuccess(
            fixtures: (fixturesState as Success).data,
          ),
      };
}
