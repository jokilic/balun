import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../../../widgets/balun_loader.dart';
import '../../../../controllers/team_transfers_controller.dart';
import 'team_transfers_content.dart';

class TeamTransfersSection extends WatchingStatefulWidget {
  final int? teamId;

  const TeamTransfersSection({
    required this.teamId,
  });

  @override
  State<TeamTransfersSection> createState() => _TeamTransfersSectionState();
}

class _TeamTransfersSectionState extends State<TeamTransfersSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<TeamTransfersController>(
          instanceName: '${widget.teamId}',
        )
        .getTransfersFromTeam(
          teamId: widget.teamId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final transfersState = watchIt<TeamTransfersController>(
      instanceName: '${widget.teamId}',
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
            error: (transfersState as Error).error ?? 'Generic team transfers error',
          ),
        Success() => TeamTransfersContent(
            transfers: (transfersState as Success).data,
          ),
      },
    );
  }
}
