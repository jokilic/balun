import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/team_transfers_controller.dart';
import 'team_transfers_content.dart';
import 'team_transfers_loading.dart';

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
      child: switch (transfersState) {
        Initial() => BalunError(
            error: 'initialState'.tr(),
            isSmall: true,
          ),
        Loading() => TeamTransfersLoading(),
        Empty() => BalunEmpty(
            message: 'teamTransfersEmptyState'.tr(),
            isSmall: true,
          ),
        Error() => BalunError(
            error: (transfersState as Error).error ?? 'teamTransfersErrorState'.tr(),
            isSmall: true,
          ),
        Success() => TeamTransfersContent(
            transfers: (transfersState as Success).data,
          ),
      },
    );
  }
}
