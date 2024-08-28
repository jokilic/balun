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
        Initial() => const BalunEmpty(
            message: "Initial state, this shouldn't happen",
          ),
        Loading() => PlayerLoading(),
        Empty() => const BalunEmpty(
            message: 'There is no player',
          ),
        Error() => BalunError(
            error: (playerState as Error).error ?? 'Generic player error',
          ),
        Success() => PlayerSuccess(
            player: (playerState as Success).data,
          ),
      };
}
