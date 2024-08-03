import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../../../widgets/balun_loader.dart';
import '../../../../controllers/match_h2h_controller.dart';
import 'match_h2h_content.dart';

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
      // TODO: Implement all states
      child: switch (head2HeadState) {
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
            error: (head2HeadState as Error).error ?? 'Generic head2head error',
          ),
        Success() => MatchHead2HeadContent(
            fixtures: (head2HeadState as Success).data,
          ),
      },
    );
  }
}
