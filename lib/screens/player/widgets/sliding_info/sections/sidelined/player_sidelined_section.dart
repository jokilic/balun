import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/player_sidelined_controller.dart';
import 'player_sidelined_content.dart';
import 'player_sidelined_loading.dart';

class PlayerSidelinedSection extends WatchingStatefulWidget {
  final int? playerId;

  const PlayerSidelinedSection({
    required this.playerId,
  });

  @override
  State<PlayerSidelinedSection> createState() => _PlayerSidelinedSectionState();
}

class _PlayerSidelinedSectionState extends State<PlayerSidelinedSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<PlayerSidelinedController>(
          instanceName: '${widget.playerId}',
        )
        .getPlayerSidelined(
          playerId: widget.playerId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final sidelinedState = watchIt<PlayerSidelinedController>(
      instanceName: '${widget.playerId}',
    ).value;

    return Animate(
      key: ValueKey(sidelinedState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      child: switch (sidelinedState) {
        Initial() => const BalunError(
            error: "Initial state, this shouldn't happen",
            verticalPadding: 0,
          ),
        Loading() => PlayerSidelinedLoading(),
        Empty() => const BalunEmpty(
            message: 'There is no player sidelined',
            verticalPadding: 0,
          ),
        Error() => BalunError(
            error: (sidelinedState as Error).error ?? 'Generic player sidelined error',
            verticalPadding: 0,
          ),
        Success() => PlayerSidelinedContent(
            sidelined: (sidelinedState as Success).data,
          ),
      },
    );
  }
}
