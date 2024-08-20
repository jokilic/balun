import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../../../widgets/balun_loader.dart';
import '../../../../controllers/player_transfers_controller.dart';
import 'player_transfers_content.dart';

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
      // TODO: Implement all states
      child: switch (transfersState) {
        Initial() => Container(
            color: Colors.green,
            height: 100,
            width: 100,
          ),
        Loading() => Center(
            child: BalunLoader(
              color: context.colors.green,
            ),
          ),
        Empty() => Container(
            color: Colors.grey,
            height: 100,
            width: 100,
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
