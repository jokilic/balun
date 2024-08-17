import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../../../widgets/balun_loader.dart';
import '../../../../controllers/team_players_controller.dart';
import 'team_players_content.dart';

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
      // TODO: Implement all states
      child: switch (playersState) {
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
