import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../../../widgets/balun_loader.dart';
import '../../../../controllers/team_leagues_controller.dart';
import 'team_leagues_content.dart';

class TeamLeaguesSection extends WatchingStatefulWidget {
  final int? teamId;

  const TeamLeaguesSection({
    required this.teamId,
  });

  @override
  State<TeamLeaguesSection> createState() => _TeamLeaguesSectionState();
}

class _TeamLeaguesSectionState extends State<TeamLeaguesSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<TeamLeaguesController>(
          instanceName: '${widget.teamId}',
        )
        .getLeaguesFromTeam(
          teamId: widget.teamId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final leaguesState = watchIt<TeamLeaguesController>(
      instanceName: '${widget.teamId}',
    ).value;

    return Animate(
      key: ValueKey(leaguesState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      // TODO: Implement all states
      child: switch (leaguesState) {
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
            error: (leaguesState as Error).error ?? 'Generic team leagues error',
          ),
        Success() => TeamLeaguesContent(
            leagues: (leaguesState as Success).data,
          ),
      },
    );
  }
}