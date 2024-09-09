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
        Initial() => const BalunError(
            error: "Initial state, this shouldn't happen",
            verticalPadding: 0,
          ),
        Loading() => LeagueTeamsLoading(),
        Empty() => const BalunEmpty(
            message: 'There are no teams',
            verticalPadding: 0,
          ),
        Error() => BalunError(
            error: (teamsState as Error).error ?? 'Generic teams error',
            verticalPadding: 0,
          ),
        Success() => LeagueTeamsContent(
            teams: (teamsState as Success).data,
            season: widget.season ?? DateTime.now().year,
          ),
      },
    );
  }
}
