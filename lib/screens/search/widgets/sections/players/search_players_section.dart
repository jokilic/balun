import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../util/state.dart';
import '../../../../../widgets/balun_empty.dart';
import '../../../../../widgets/balun_error.dart';
import '../../../controllers/search_players_controller.dart';
import 'search_players_loading.dart';
import 'search_players_success.dart';

class SearchPlayersSection extends WatchingWidget {
  @override
  Widget build(BuildContext context) {
    final searchPlayersState = watchIt<SearchPlayersController>(
      instanceName: 'search',
    ).value;

    return switch (searchPlayersState) {
      Initial() => BalunEmpty(
          message: 'searchPlayersInitialState'.tr(),
          smallMessage: 'searchPlayersSmallText'.tr(),
        ),
      Loading() => SearchPlayersLoading(),
      Empty() => BalunEmpty(
          message: 'searchPlayersEmptyState'.tr(),
          smallMessage: 'searchPlayersSmallText'.tr(),
        ),
      Error() => BalunError(
          error: (searchPlayersState as Error).error ?? 'searchPlayersErrorState'.tr(),
        ),
      Success() => SearchPlayersSuccess(
          players: (searchPlayersState as Success).data,
        ),
    };
  }
}
