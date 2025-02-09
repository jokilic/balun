import 'package:easy_localization/easy_localization.dart';
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
  final String? season;

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
        Initial() => BalunError(
            error: 'initialState'.tr(),
            isSmall: true,
          ),
        Loading() => LeagueStandingsLoading(),
        Empty() => BalunEmpty(
            message: 'leagueStandingsEmptyState'.tr(),
            isSmall: true,
          ),
        Error() => BalunError(
            error: (standingsState as Error).error ?? 'leagueStandingsErrorState'.tr(),
            isSmall: true,
          ),
        Success() => LeagueStandingsContent(
            standings: (standingsState as Success).data,
          ),
      },
    );
  }
}
