import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../../../widgets/balun_loader.dart';
import '../../../../controllers/league_top_red_cards_controller.dart';
import 'league_top_red_cards_content.dart';

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
      // TODO: Implement all states
      child: switch (topRedCardsState) {
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
            error: (topRedCardsState as Error).error ?? 'Generic top red cards error',
          ),
        Success() => LeagueTopRedCardsContent(
            redCards: (topRedCardsState as Success).data,
            season: widget.season ?? DateTime.now().year,
          ),
      },
    );
  }
}
