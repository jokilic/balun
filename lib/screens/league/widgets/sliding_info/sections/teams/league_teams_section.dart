import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/league_teams_controller.dart';
import 'league_teams_content.dart';
import 'league_teams_loading.dart';

class LeagueTeamsSection extends WatchingStatefulWidget {
  final int? leagueId;
  final int? season;

  const LeagueTeamsSection({
    required this.leagueId,
    required this.season,
  });

  @override
  State<LeagueTeamsSection> createState() => _LeagueTeamsSectionState();
}

class _LeagueTeamsSectionState extends State<LeagueTeamsSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<LeagueTeamsController>(
          instanceName: '${widget.leagueId}',
        )
        .getTeamsFromLeagueAndSeason(
          leagueId: widget.leagueId,
          season: widget.season,
        );
  }

  @override
  Widget build(BuildContext context) {
    final teamsState = watchIt<LeagueTeamsController>(
      instanceName: '${widget.leagueId}',
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
        Loading() => LeagueTeamsLoading(),
        Empty() => BalunEmpty(
            message: 'leagueTeamsEmptyState'.tr(),
            isSmall: true,
          ),
        Error() => BalunError(
            error: (teamsState as Error).error ?? 'leagueTeamsErrorState'.tr(),
            isSmall: true,
          ),
        Success() => LeagueTeamsContent(
            teams: (teamsState as Success).data,
            season: widget.season ?? DateTime.now().year,
          ),
      },
    );
  }
}
