import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../util/state.dart';
import '../../../../../widgets/balun_empty.dart';
import '../../../../../widgets/balun_error.dart';
import '../../../controllers/search_teams_controller.dart';
import 'search_teams_loading.dart';
import 'search_teams_success.dart';

class SearchTeamsSection extends WatchingWidget {
  @override
  Widget build(BuildContext context) {
    final searchTeamsState = watchIt<SearchTeamsController>(
      instanceName: 'search',
    ).value;

    return switch (searchTeamsState) {
      Initial() => const BalunEmpty(
          message: 'Search for teams',
        ),
      Loading() => SearchTeamsLoading(),
      Empty() => const BalunEmpty(
          message: 'There are no teams',
        ),
      Error() => BalunError(
          error: (searchTeamsState as Error).error ?? 'Generic search teams error',
        ),
      Success() => SearchTeamsSuccess(
          teams: (searchTeamsState as Success).data,
        ),
    };
  }
}
