import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_loader.dart';
import '../../../../controllers/match_standings_controller.dart';
import 'match_standings_content.dart';

class MatchStandingsSection extends WatchingStatefulWidget {
  final int? leagueId;
  final int? season;

  const MatchStandingsSection({
    required this.leagueId,
    required this.season,
  });

  @override
  State<MatchStandingsSection> createState() => _MatchStandingsSectionState();
}

class _MatchStandingsSectionState extends State<MatchStandingsSection> {
  @override
  void initState() {
    super.initState();
    getIt.get<MatchStandingsController>().getStandings(
          leagueId: widget.leagueId,
          season: widget.season,
        );
  }

  @override
  Widget build(BuildContext context) {
    final standingsState = watchIt<MatchStandingsController>().value;

    return Animate(
      key: ValueKey(standingsState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      child: switch (standingsState) {
        Initial() => Container(
            color: Colors.green,
            height: 100,
            width: 100,
          ),
        Loading() => Center(
            child: BalunLoader(
              color: context.colors.greenish,
            ),
          ),
        Empty() => Container(
            color: Colors.grey,
            height: 100,
            width: 100,
          ),
        Error() => Container(
            color: Colors.red,
            child: Center(
              child: Text(
                (standingsState as Error).error ?? 'Generic standings error',
                style: context.textStyles.fixturesName,
              ),
            ),
          ),
        Success() => MatchStandingsContent(
            league: (standingsState as Success).data,
          ),
      },
    );
  }
}
