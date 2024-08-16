import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../../../widgets/balun_loader.dart';
import '../../../../controllers/team_standings_controller.dart';
import 'team_standings_content.dart';

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
      // TODO: Implement all states
      child: switch (standingsState) {
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
            error: (standingsState as Error).error ?? 'Generic team standings error',
          ),
        Success() => TeamStandingsContent(
            standings: (standingsState as Success).data,
            season: widget.season,
          ),
      },
    );
  }
}
