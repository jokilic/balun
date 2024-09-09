import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/team_coaches_controller.dart';
import 'team_coaches_content.dart';
import 'team_coaches_loading.dart';

class TeamCoachesSection extends WatchingStatefulWidget {
  final int? teamId;

  const TeamCoachesSection({
    required this.teamId,
  });

  @override
  State<TeamCoachesSection> createState() => _TeamCoachesSectionState();
}

class _TeamCoachesSectionState extends State<TeamCoachesSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<TeamCoachesController>(
          instanceName: '${widget.teamId}',
        )
        .getCoachesFromTeam(
          teamId: widget.teamId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final coachesState = watchIt<TeamCoachesController>(
      instanceName: '${widget.teamId}',
    ).value;

    return Animate(
      key: ValueKey(coachesState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      child: switch (coachesState) {
        Initial() => const BalunError(
            error: "Initial state, this shouldn't happen",
            isSmall: true,
          ),
        Loading() => TeamCoachesLoading(),
        Empty() => const BalunEmpty(
            message: 'There are no team coaches',
            isSmall: true,
          ),
        Error() => BalunError(
            error: (coachesState as Error).error ?? 'Generic team coaches error',
            isSmall: true,
          ),
        Success() => TeamCoachesContent(
            coaches: (coachesState as Success).data,
          ),
      },
    );
  }
}
