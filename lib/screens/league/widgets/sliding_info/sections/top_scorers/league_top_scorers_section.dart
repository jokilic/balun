import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/date_time.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/league_top_scorers_controller.dart';
import 'league_top_scorers_content.dart';
import 'league_top_scorers_loading.dart';

class LeagueTopScorersSection extends WatchingStatefulWidget {
  final int? leagueId;
  final String? season;

  const LeagueTopScorersSection({
    required this.leagueId,
    required this.season,
  });

  @override
  State<LeagueTopScorersSection> createState() => _LeagueTopScorersSectionState();
}

class _LeagueTopScorersSectionState extends State<LeagueTopScorersSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<LeagueTopScorersController>(
          instanceName: '${widget.leagueId}',
        )
        .getTopScorers(
          leagueId: widget.leagueId,
          season: widget.season,
        );
  }

  @override
  Widget build(BuildContext context) {
    final topScorersState = watchIt<LeagueTopScorersController>(
      instanceName: '${widget.leagueId}',
    ).value;

    return Animate(
      key: ValueKey(topScorersState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      child: switch (topScorersState) {
        Initial() => BalunError(
            error: 'initialState'.tr(),
            isSmall: true,
          ),
        Loading() => LeagueTopScorersLoading(),
        Empty() => BalunEmpty(
            message: 'leagueTopScorersEmptyState'.tr(),
            isSmall: true,
          ),
        Error() => BalunError(
            error: (topScorersState as Error).error ?? 'leagueTopScorersErrorState'.tr(),
            isSmall: true,
          ),
        Success() => LeagueTopScorersContent(
            scorers: (topScorersState as Success).data,
            season: widget.season ?? getCurrentSeasonYear().toString(),
          ),
      },
    );
  }
}
