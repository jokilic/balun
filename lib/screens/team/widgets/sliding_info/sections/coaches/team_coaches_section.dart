import 'package:easy_localization/easy_localization.dart';
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
        Initial() => BalunError(
            error: 'initialState'.tr(),
            isSmall: true,
          ),
        Loading() => TeamCoachesLoading(),
        Empty() => BalunEmpty(
            message: 'teamCoachesEmptyState'.tr(),
            isSmall: true,
          ),
        Error() => BalunError(
            error: (coachesState as Error).error ?? 'teamCoachesErrorState'.tr(),
            isSmall: true,
          ),
        Success() => TeamCoachesContent(
            coaches: (coachesState as Success).data,
          ),
      },
    );
  }
}
