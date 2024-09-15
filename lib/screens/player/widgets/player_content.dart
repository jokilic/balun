import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../util/state.dart';
import '../../../widgets/balun_empty.dart';
import '../../../widgets/balun_error.dart';
import 'player_loading.dart';
import 'player_success.dart';

class PlayerContent extends StatelessWidget {
  final BalunState playerState;

  const PlayerContent({
    required this.playerState,
  });

  @override
  Widget build(BuildContext context) => switch (playerState) {
        Initial() => BalunError(
            error: 'initialState'.tr(),
          ),
        Loading() => PlayerLoading(),
        Empty() => BalunEmpty(
            message: 'playerEmptyState'.tr(),
          ),
        Error() => BalunError(
            error: (playerState as Error).error ?? 'playerErrorState'.tr(),
          ),
        Success() => PlayerSuccess(
            player: (playerState as Success).data,
          ),
      };
}
