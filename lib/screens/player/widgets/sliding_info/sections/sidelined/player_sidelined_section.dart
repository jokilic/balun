import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../../../widgets/balun_loader.dart';
import '../../../../controllers/player_sidelined_controller.dart';
import 'player_sidelined_content.dart';

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
      // TODO: Implement all states
      child: switch (sidelinedState) {
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
            error: (sidelinedState as Error).error ?? 'Generic player sidelined error',
          ),
        Success() => PlayerSidelinedContent(
            sidelined: (sidelinedState as Success).data,
          ),
      },
    );
  }
}
