import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/league_top_yellow_cards_controller.dart';
import 'league_top_yellow_cards_content.dart';
import 'league_top_yellow_cards_loading.dart';

class LeagueTopYellowCardsSection extends WatchingStatefulWidget {
  final int? leagueId;
  final int? season;

  const LeagueTopYellowCardsSection({
    required this.leagueId,
    required this.season,
  });

  @override
  State<LeagueTopYellowCardsSection> createState() => _LeagueTopYellowCardsSectionState();
}

class _LeagueTopYellowCardsSectionState extends State<LeagueTopYellowCardsSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<LeagueTopYellowCardsController>(
          instanceName: '${widget.leagueId}',
        )
        .getTopYellowCards(
          leagueId: widget.leagueId,
          season: widget.season,
        );
  }

  @override
  Widget build(BuildContext context) {
    final topYellowCardsState = watchIt<LeagueTopYellowCardsController>(
      instanceName: '${widget.leagueId}',
    ).value;

    return Animate(
      key: ValueKey(topYellowCardsState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      child: switch (topYellowCardsState) {
        Initial() => BalunError(
            error: 'initialState'.tr(),
            isSmall: true,
          ),
        Loading() => LeagueTopYellowCardsLoading(),
        Empty() => BalunEmpty(
            message: 'leagueTopYellowCardsEmptyState'.tr(),
            isSmall: true,
          ),
        Error() => BalunError(
            error: (topYellowCardsState as Error).error ?? 'leagueTopYellowCardsErrorState'.tr(),
            isSmall: true,
          ),
        Success() => LeagueTopYellowCardsContent(
            yellowCards: (topYellowCardsState as Success).data,
            season: widget.season ?? DateTime.now().year,
          ),
      },
    );
  }
}
