import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/match_highlights_controller.dart';
import 'match_highlights_content.dart';
import 'match_highlights_loading.dart';

class MatchHighlightsSection extends WatchingStatefulWidget {
  final int? matchId;
  final String? homeTeamName;
  final String? awayTeamName;
  final DateTime? matchDate;
  final String? leagueName;

  const MatchHighlightsSection({
    required this.matchId,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.matchDate,
    required this.leagueName,
  });

  @override
  State<MatchHighlightsSection> createState() => _MatchHighlightsSectionState();
}

class _MatchHighlightsSectionState extends State<MatchHighlightsSection> {
  @override
  void initState() {
    super.initState();

    getIt
        .get<MatchHighlightsController>(
          instanceName: '${widget.matchId}',
        )
        .getHighlights(
          homeTeamName: widget.homeTeamName,
          awayTeamName: widget.awayTeamName,
          matchDate: widget.matchDate,
          leagueName: widget.leagueName,
        );
  }

  @override
  Widget build(BuildContext context) {
    final highlightsState = watchIt<MatchHighlightsController>(
      instanceName: '${widget.matchId}',
    ).value;

    return Animate(
      key: highlightsState is Success ? null : ValueKey(highlightsState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      child: switch (highlightsState) {
        Initial() => BalunError(
            error: 'initialState'.tr(),
            isSmall: true,
          ),
        Loading() => MatchHighlightsLoading(),
        Empty() => BalunEmpty(
            message: 'matchHighlightsEmptyState'.tr(),
            isSmall: true,
          ),
        Error() => BalunError(
            error: (highlightsState as Error).error ?? 'matchHighlightsErrorState'.tr(),
            isSmall: true,
          ),
        Success() => MatchHighlightsContent(
            youTubeData: (highlightsState as Success).data,
            matchId: widget.matchId,
          ),
      },
    );
  }
}
