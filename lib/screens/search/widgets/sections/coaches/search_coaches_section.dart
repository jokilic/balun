import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../util/state.dart';
import '../../../../../widgets/balun_empty.dart';
import '../../../../../widgets/balun_error.dart';
import '../../../controllers/search_coaches_controller.dart';
import 'search_coaches_loading.dart';
import 'search_coaches_success.dart';

class SearchCoachesSection extends WatchingWidget {
  @override
  Widget build(BuildContext context) {
    final searchCoachesState = watchIt<SearchCoachesController>(
      instanceName: 'search',
    ).value;

    return switch (searchCoachesState) {
      Initial() => const BalunEmpty(
          message: 'Search for coaches',
        ),
      Loading() => SearchCoachesLoading(),
      Empty() => const BalunEmpty(
          message: 'There are no coaches',
        ),
      Error() => BalunError(
          error: (searchCoachesState as Error).error ?? 'Generic search coaches error',
        ),
      Success() => SearchCoachesSuccess(
          coaches: (searchCoachesState as Success).data,
        ),
    };
  }
}
