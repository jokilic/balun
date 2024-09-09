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
        Initial() => const BalunError(
            error: "Initial state, this shouldn't happen",
            verticalPadding: 0,
          ),
        Loading() => LeagueTopYellowCardsLoading(),
        Empty() => const BalunEmpty(
            message: 'There are no top yellow cards',
            verticalPadding: 0,
          ),
        Error() => BalunError(
            error: (topYellowCardsState as Error).error ?? 'Generic top yellow cards error',
            verticalPadding: 0,
          ),
        Success() => LeagueTopYellowCardsContent(
            yellowCards: (topYellowCardsState as Success).data,
            season: widget.season ?? DateTime.now().year,
          ),
      },
    );
  }
}
