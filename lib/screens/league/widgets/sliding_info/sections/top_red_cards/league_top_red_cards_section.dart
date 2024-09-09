import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/league_top_red_cards_controller.dart';
import 'league_top_red_cards_content.dart';
import 'league_top_red_cards_loading.dart';

class LeagueTopRedCardsSection extends WatchingStatefulWidget {
  final int? leagueId;
  final int? season;

  const LeagueTopRedCardsSection({
    required this.leagueId,
    required this.season,
  });

  @override
  State<LeagueTopRedCardsSection> createState() => _LeagueTopRedCardsSectionState();
}

class _LeagueTopRedCardsSectionState extends State<LeagueTopRedCardsSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<LeagueTopRedCardsController>(
          instanceName: '${widget.leagueId}',
        )
        .getTopRedCards(
          leagueId: widget.leagueId,
          season: widget.season,
        );
  }

  @override
  Widget build(BuildContext context) {
    final topRedCardsState = watchIt<LeagueTopRedCardsController>(
      instanceName: '${widget.leagueId}',
    ).value;

    return Animate(
      key: ValueKey(topRedCardsState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      child: switch (topRedCardsState) {
        Initial() => const BalunError(
            error: "Initial state, this shouldn't happen",
            isSmall: true,
          ),
        Loading() => LeagueTopRedCardsLoading(),
        Empty() => const BalunEmpty(
            message: 'There are no top red cards',
            isSmall: true,
          ),
        Error() => BalunError(
            error: (topRedCardsState as Error).error ?? 'Generic top red cards error',
            isSmall: true,
          ),
        Success() => LeagueTopRedCardsContent(
            redCards: (topRedCardsState as Success).data,
            season: widget.season ?? DateTime.now().year,
          ),
      },
    );
  }
}
