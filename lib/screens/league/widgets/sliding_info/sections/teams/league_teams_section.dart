import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../../../widgets/balun_loader.dart';
import '../../../../controllers/league_teams_controller.dart';
import 'league_teams_content.dart';

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
      // TODO: Implement all states
      child: switch (teamsState) {
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
            error: (teamsState as Error).error ?? 'Generic teams error',
          ),
        Success() => LeagueTeamsContent(
            teams: (teamsState as Success).data,
          ),
      },
    );
  }
}
