import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/league_standings_controller.dart';
import 'league_standings_content.dart';
import 'league_standings_loading.dart';

class LeagueStandingsSection extends WatchingStatefulWidget {
  final int? leagueId;
  final int? season;

  const LeagueStandingsSection({
    required this.leagueId,
    required this.season,
  });

  @override
  State<LeagueStandingsSection> createState() => _LeagueStandingsSectionState();
}

class _LeagueStandingsSectionState extends State<LeagueStandingsSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<LeagueStandingsController>(
          instanceName: '${widget.leagueId}',
        )
        .getStandingsFromLeagueAndSeason(
          leagueId: widget.leagueId,
          season: widget.season,
        );
  }

  @override
  Widget build(BuildContext context) {
    final standingsState = watchIt<LeagueStandingsController>(
      instanceName: '${widget.leagueId}',
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
        Loading() => LeagueStandingsLoading(),
        Empty() => const BalunEmpty(
            message: 'There are no standings',
          ),
        Error() => BalunError(
            error: (standingsState as Error).error ?? 'Generic standings error',
          ),
        Success() => LeagueStandingsContent(
            standings: (standingsState as Success).data,
          ),
      },
    );
  }
}
