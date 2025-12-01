import 'package:easy_localization/easy_localization.dart';
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
    Initial() => BalunError(
      error: 'initialState'.tr(),
      hasBackButton: true,
    ),
    Loading() => FixturesLoading(),
    Empty() => BalunEmpty(
      message: 'fixturesEmptyState'.tr(),
      hasBackButton: true,
    ),
    Error() => BalunError(
      error: (fixturesState as Error).error ?? 'fixturesErrorState'.tr(),
      hasBackButton: true,
    ),
    Success() => FixturesSuccess(
      fixtures: (fixturesState as Success).data,
    ),
  };
}
