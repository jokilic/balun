import 'package:easy_localization/easy_localization.dart';
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
  final String? season;

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
        Initial() => BalunError(
            error: 'initialState'.tr(),
            isSmall: true,
          ),
        Loading() => LeagueFixturesLoading(),
        Empty() => BalunEmpty(
            message: 'leagueFixturesEmptyState'.tr(),
            isSmall: true,
          ),
        Error() => BalunError(
            error: (fixturesState as Error).error ?? 'leagueFixturesErrorState'.tr(),
            isSmall: true,
          ),
        Success() => LeagueFixturesContent(
            fixtures: (fixturesState as Success).data,
          ),
      },
    );
  }
}
