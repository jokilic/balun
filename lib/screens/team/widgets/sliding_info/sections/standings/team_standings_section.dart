import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/team_standings_controller.dart';
import 'team_standings_content.dart';
import 'team_standings_loading.dart';

class TeamStandingsSection extends WatchingStatefulWidget {
  final int? teamId;
  final int? season;

  const TeamStandingsSection({
    required this.teamId,
    required this.season,
  });

  @override
  State<TeamStandingsSection> createState() => _TeamStandingsSectionState();
}

class _TeamStandingsSectionState extends State<TeamStandingsSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<TeamStandingsController>(
          instanceName: '${widget.teamId}',
        )
        .getStandingsFromTeam(
          teamId: widget.teamId,
          season: widget.season,
        );
  }

  @override
  Widget build(BuildContext context) {
    final standingsState = watchIt<TeamStandingsController>(
      instanceName: '${widget.teamId}',
    ).value;

    return Animate(
      key: ValueKey(standingsState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      child: switch (standingsState) {
        Initial() => const BalunEmpty(
            message: "Initial state, this shouldn't happen",
          ),
        Loading() => TeamStandingsLoading(),
        Empty() => const BalunEmpty(
            message: 'There are no team standings',
          ),
        Error() => BalunError(
            error: (standingsState as Error).error ?? 'Generic team standings error',
          ),
        Success() => TeamStandingsContent(
            standings: (standingsState as Success).data,
          ),
      },
    );
  }
}
