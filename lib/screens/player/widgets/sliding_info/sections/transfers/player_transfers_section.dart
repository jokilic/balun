import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/player_transfers_controller.dart';
import 'player_transfers_content.dart';
import 'player_transfers_loading.dart';

class PlayerTransfersSection extends WatchingStatefulWidget {
  final int? playerId;

  const PlayerTransfersSection({
    required this.playerId,
  });

  @override
  State<PlayerTransfersSection> createState() => _PlayerTransfersSectionState();
}

class _PlayerTransfersSectionState extends State<PlayerTransfersSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<PlayerTransfersController>(
          instanceName: '${widget.playerId}',
        )
        .getPlayerTransfers(
          playerId: widget.playerId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final transfersState = watchIt<PlayerTransfersController>(
      instanceName: '${widget.playerId}',
    ).value;

    return Animate(
      key: ValueKey(transfersState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      child: switch (transfersState) {
        Initial() => const BalunEmpty(
            message: "Initial state, this shouldn't happen",
          ),
        Loading() => PlayerTransfersLoading(),
        Empty() => const BalunEmpty(
            message: 'There are no player transfers',
            verticalPadding: 0,
          ),
        Error() => BalunError(
            error: (transfersState as Error).error ?? 'Generic player transfers error',
          ),
        Success() => PlayerTransfersContent(
            transfers: (transfersState as Success).data,
          ),
      },
    );
  }
}
