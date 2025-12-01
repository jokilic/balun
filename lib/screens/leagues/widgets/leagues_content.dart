import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../util/state.dart';
import '../../../widgets/balun_empty.dart';
import '../../../widgets/balun_error.dart';
import 'leagues_loading.dart';
import 'leagues_success.dart';

class LeaguesContent extends StatelessWidget {
  final BalunState leaguesState;

  const LeaguesContent({
    required this.leaguesState,
  });

  @override
  Widget build(BuildContext context) => switch (leaguesState) {
    Initial() => BalunError(
      error: 'initialState'.tr(),
      hasBackButton: true,
    ),
    Loading() => LeaguesLoading(),
    Empty() => BalunEmpty(
      message: 'leaguesEmptyState'.tr(),
      hasBackButton: true,
    ),
    Error() => BalunError(
      error: (leaguesState as Error).error ?? 'leaguesErrorState'.tr(),
      hasBackButton: true,
    ),
    Success() => LeaguesSuccess(
      leagues: (leaguesState as Success).data,
    ),
  };
}
