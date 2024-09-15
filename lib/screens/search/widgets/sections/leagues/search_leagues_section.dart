import 'package:easy_localization/easy_localization.dart';
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
      Initial() => BalunEmpty(
          message: 'searchLeaguesInitialState'.tr(),
        ),
      Loading() => SearchLeaguesLoading(),
      Empty() => BalunEmpty(
          message: 'searchLeaguesEmptyState'.tr(),
        ),
      Error() => BalunError(
          error: (searchLeaguesState as Error).error ?? 'searchLeaguesErrorState'.tr(),
        ),
      Success() => SearchLeaguesSuccess(
          leagues: (searchLeaguesState as Success).data,
        ),
    };
  }
}
