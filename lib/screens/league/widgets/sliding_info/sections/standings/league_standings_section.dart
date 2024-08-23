import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../../../widgets/balun_loader.dart';
import '../../../../controllers/league_standings_controller.dart';
import 'league_standings_content.dart';

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
            error: (standingsState as Error).error ?? 'Generic standings error',
          ),
        Success() => LeagueStandingsContent(
            standings: (standingsState as Success).data,
          ),
      },
    );
  }
}
