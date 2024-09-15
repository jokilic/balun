import 'package:easy_localization/easy_localization.dart';
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
      Initial() => BalunEmpty(
          message: 'searchCoachesInitialState'.tr(),
        ),
      Loading() => SearchCoachesLoading(),
      Empty() => BalunEmpty(
          message: 'searchCoachesEmptyState'.tr(),
        ),
      Error() => BalunError(
          error: (searchCoachesState as Error).error ?? 'searchCoachesErrorState'.tr(),
        ),
      Success() => SearchCoachesSuccess(
          coaches: (searchCoachesState as Success).data,
        ),
    };
  }
}
