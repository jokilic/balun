import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../util/state.dart';
import '../../../widgets/balun_empty.dart';
import '../../../widgets/balun_error.dart';
import 'league_loading.dart';
import 'league_success.dart';

class LeagueContent extends StatelessWidget {
  final BalunState leagueState;

  const LeagueContent({
    required this.leagueState,
  });

  @override
  Widget build(BuildContext context) => switch (leagueState) {
    Initial() => BalunError(
      error: 'initialState'.tr(),
      hasBackButton: true,
    ),
    Loading() => LeagueLoading(),
    Empty() => BalunEmpty(
      message: 'leagueEmptyState'.tr(),
      hasBackButton: true,
    ),
    Error() => BalunError(
      error: (leagueState as Error).error ?? 'leagueErrorState'.tr(),
      hasBackButton: true,
    ),
    Success() => LeagueSuccess(
      league: (leagueState as Success).data,
    ),
  };
}
