import 'package:easy_localization/easy_localization.dart';
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
      Initial() => BalunEmpty(
          message: 'searchTeamsInitialState'.tr(),
          smallMessage: 'searchSmallText'.tr(),
        ),
      Loading() => SearchTeamsLoading(),
      Empty() => BalunEmpty(
          message: 'searchTeamsEmptyState'.tr(),
          smallMessage: 'searchSmallText'.tr(),
        ),
      Error() => BalunError(
          error: (searchTeamsState as Error).error ?? 'searchTeamsErrorState'.tr(),
        ),
      Success() => SearchTeamsSuccess(
          teams: (searchTeamsState as Success).data,
        ),
    };
  }
}
