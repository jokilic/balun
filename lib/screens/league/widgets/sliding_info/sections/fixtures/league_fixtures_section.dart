import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/league_fixtures_controller.dart';
import 'league_fixtures_content.dart';
import 'league_fixtures_loading.dart';

class LeagueFixturesSection extends WatchingStatefulWidget {
  final int? leagueId;
  final int? season;

  const LeagueFixturesSection({
    required this.leagueId,
    required this.season,
  });

  @override
  State<LeagueFixturesSection> createState() => _LeagueFixturesSectionState();
}

class _LeagueFixturesSectionState extends State<LeagueFixturesSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<LeagueFixturesController>(
          instanceName: '${widget.leagueId}',
        )
        .getFixturesFromLeagueAndSeason(
          leagueId: widget.leagueId,
          season: widget.season,
        );
  }

  @override
  Widget build(BuildContext context) {
    final fixturesState = watchIt<LeagueFixturesController>(
      instanceName: '${widget.leagueId}',
    ).value;

    return Animate(
      key: ValueKey(fixturesState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      child: switch (fixturesState) {
        Initial() => const BalunError(
            error: "Initial state, this shouldn't happen",
            verticalPadding: 0,
          ),
        Loading() => LeagueFixturesLoading(),
        Empty() => const BalunEmpty(
            message: 'There are no fixtures',
            verticalPadding: 0,
          ),
        Error() => BalunError(
            error: (fixturesState as Error).error ?? 'Generic fixtures error',
            verticalPadding: 0,
          ),
        Success() => LeagueFixturesContent(
            fixtures: (fixturesState as Success).data,
          ),
      },
    );
  }
}
