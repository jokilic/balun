import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/team_players_controller.dart';
import 'team_players_content.dart';
import 'team_players_loading.dart';

class TeamPlayersSection extends WatchingStatefulWidget {
  final int? teamId;
  final int season;

  const TeamPlayersSection({
    required this.teamId,
    required this.season,
  });

  @override
  State<TeamPlayersSection> createState() => _TeamPlayersSectionState();
}

class _TeamPlayersSectionState extends State<TeamPlayersSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<TeamPlayersController>(
          instanceName: '${widget.teamId}',
        )
        .getPlayersFromTeam(
          teamId: widget.teamId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final playersState = watchIt<TeamPlayersController>(
      instanceName: '${widget.teamId}',
    ).value;

    return Animate(
      key: ValueKey(playersState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      child: switch (playersState) {
        Initial() => const BalunEmpty(
            message: "Initial state, this shouldn't happen",
          ),
        Loading() => TeamPlayersLoading(),
        Empty() => const BalunEmpty(
            message: 'There are no team players',
            verticalPadding: 0,
          ),
        Error() => BalunError(
            error: (playersState as Error).error ?? 'Generic team players error',
          ),
        Success() => TeamPlayersContent(
            players: (playersState as Success).data,
            season: widget.season,
          ),
      },
    );
  }
}
