import 'package:flutter/material.dart';

import '../../../util/state.dart';
import '../../../widgets/balun_error.dart';
import '../../../widgets/balun_loader.dart';
import 'player_success.dart';

class PlayerContent extends StatelessWidget {
  final BalunState playerState;

  const PlayerContent({
    required this.playerState,
  });

  @override
  Widget build(BuildContext context) => switch (playerState) {
        Initial() => Container(color: Colors.green),
        Loading() => const Center(child: BalunLoader()),
        Empty() => Container(color: Colors.grey),
        Error() => BalunError(
            error: (playerState as Error).error ?? 'Generic player error',
          ),
        Success() => PlayerSuccess(
            player: (playerState as Success).data,
          ),
      };
}
