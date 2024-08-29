import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../util/state.dart';
import '../../../../../widgets/balun_empty.dart';
import '../../../../../widgets/balun_error.dart';
import '../../../controllers/search_leagues_controller.dart';
import 'search_leagues_loading.dart';
import 'search_leagues_success.dart';

class SearchLeaguesSection extends WatchingWidget {
  @override
  Widget build(BuildContext context) {
    final searchLeaguesState = watchIt<SearchLeaguesController>(
      instanceName: 'search',
    ).value;

    return switch (searchLeaguesState) {
      Initial() => const BalunEmpty(
          message: 'Search for leagues',
        ),
      Loading() => SearchLeaguesLoading(),
      Empty() => const BalunEmpty(
          message: 'There are no leagues',
        ),
      Error() => BalunError(
          error: (searchLeaguesState as Error).error ?? 'Generic search leagues error',
        ),
      Success() => SearchLeaguesSuccess(
          leagues: (searchLeaguesState as Success).data,
        ),
    };
  }
}
