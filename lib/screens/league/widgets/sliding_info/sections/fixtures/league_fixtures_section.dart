import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../../../widgets/balun_loader.dart';
import '../../../../controllers/league_fixtures_controller.dart';
import 'league_fixtures_content.dart';

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
      // TODO: Implement all states
      child: switch (fixturesState) {
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
            error: (fixturesState as Error).error ?? 'Generic fixtures error',
          ),
        Success() => LeagueFixturesContent(
            fixtures: (fixturesState as Success).data,
          ),
      },
    );
  }
}
