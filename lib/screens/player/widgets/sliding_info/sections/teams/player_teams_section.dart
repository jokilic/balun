import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/player_teams_controller.dart';
import 'player_teams_content.dart';
import 'player_teams_loading.dart';

class PlayerTeamsSection extends WatchingStatefulWidget {
  final int? playerId;

  const PlayerTeamsSection({
    required this.playerId,
  });

  @override
  State<PlayerTeamsSection> createState() => _PlayerTeamsSectionState();
}

class _PlayerTeamsSectionState extends State<PlayerTeamsSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<PlayerTeamsController>(
          instanceName: '${widget.playerId}',
        )
        .getPlayerTeams(
          playerId: widget.playerId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final teamsState = watchIt<PlayerTeamsController>(
      instanceName: '${widget.playerId}',
    ).value;

    return Animate(
      key: ValueKey(teamsState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      child: switch (teamsState) {
        Initial() => BalunError(
            error: 'initialState'.tr(),
            isSmall: true,
          ),
        Loading() => PlayerTeamsLoading(),
        Empty() => BalunEmpty(
            message: 'playerTeamsEmptyState'.tr(),
            isSmall: true,
          ),
        Error() => BalunError(
            error: (teamsState as Error).error ?? 'playerTeamsErrorState'.tr(),
            isSmall: true,
          ),
        Success() => PlayerTeamsContent(
            teams: (teamsState as Success).data,
          ),
      },
    );
  }
}
