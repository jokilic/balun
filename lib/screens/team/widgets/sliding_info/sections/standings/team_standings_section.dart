import 'package:easy_localization/easy_localization.dart';
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
  final String? season;

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
        Initial() => BalunError(
            error: 'initialState'.tr(),
            isSmall: true,
          ),
        Loading() => TeamStandingsLoading(),
        Empty() => BalunEmpty(
            message: 'teamStandingsEmptyState'.tr(),
            isSmall: true,
          ),
        Error() => BalunError(
            error: (standingsState as Error).error ?? 'teamStandingsErrorState'.tr(),
            isSmall: true,
          ),
        Success() => TeamStandingsContent(
            standings: (standingsState as Success).data,
          ),
      },
    );
  }
}
