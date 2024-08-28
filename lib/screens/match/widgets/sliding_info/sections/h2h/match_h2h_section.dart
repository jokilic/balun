import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/match_h2h_controller.dart';
import 'match_h2h_content.dart';
import 'match_h2h_loading.dart';

class MatchHead2HeadSection extends WatchingStatefulWidget {
  final int? matchId;
  final int? homeTeamId;
  final int? awayTeamId;

  const MatchHead2HeadSection({
    required this.matchId,
    required this.homeTeamId,
    required this.awayTeamId,
  });

  @override
  State<MatchHead2HeadSection> createState() => _MatchHead2HeadSectionState();
}

class _MatchHead2HeadSectionState extends State<MatchHead2HeadSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<MatchHead2HeadController>(
          instanceName: '${widget.matchId}',
        )
        .getHead2Head(
          homeTeamId: widget.homeTeamId,
          awayTeamId: widget.awayTeamId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final head2HeadState = watchIt<MatchHead2HeadController>(
      instanceName: '${widget.matchId}',
    ).value;

    return Animate(
      key: ValueKey(head2HeadState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      child: switch (head2HeadState) {
        Initial() => const BalunEmpty(
            message: "Initial state, this shouldn't happen",
          ),
        Loading() => MatchHead2HeadLoading(),
        Empty() => const BalunEmpty(
            message: 'There is no head-to-head',
            verticalPadding: 0,
          ),
        Error() => BalunError(
            error: (head2HeadState as Error).error ?? 'Generic head2head error',
          ),
        Success() => MatchHead2HeadContent(
            fixtures: (head2HeadState as Success).data,
          ),
      },
    );
  }
}
