import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/team_matches_controller.dart';
import 'team_matches_content.dart';
import 'team_matches_loading.dart';

class TeamMatchesSection extends WatchingStatefulWidget {
  final int? teamId;
  final int lastNumber;
  final int nextNumber;

  const TeamMatchesSection({
    required this.teamId,
    required this.lastNumber,
    required this.nextNumber,
  });

  @override
  State<TeamMatchesSection> createState() => _TeamMatchesSectionState();
}

class _TeamMatchesSectionState extends State<TeamMatchesSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<TeamMatchesController>(
          instanceName: '${widget.teamId}',
        )
        .getFixturesFromTeam(
          teamId: widget.teamId,
          lastNumber: widget.lastNumber,
          nextNumber: widget.nextNumber,
        );
  }

  @override
  Widget build(BuildContext context) {
    final matchesState = watchIt<TeamMatchesController>(
      instanceName: '${widget.teamId}',
    ).value;

    return Animate(
      key: ValueKey(matchesState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      child: switch (matchesState) {
        Initial() => BalunError(
          error: 'initialState'.tr(),
          isSmall: true,
        ),
        Loading() => TeamMatchesLoading(),
        Empty() => BalunEmpty(
          message: 'teamMatchesEmptyState'.tr(),
          isSmall: true,
        ),
        Error() => BalunError(
          error: (matchesState as Error).error ?? 'teamMatchesErrorState'.tr(),
          isSmall: true,
        ),
        Success() => TeamMatchesContent(
          fixtures: (matchesState as Success).data,
        ),
      },
    );
  }
}
