import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/league_top_assists_controller.dart';
import 'league_top_assists_content.dart';
import 'league_top_assists_loading.dart';

class LeagueTopAssistsSection extends WatchingStatefulWidget {
  final int? leagueId;
  final int? season;

  const LeagueTopAssistsSection({
    required this.leagueId,
    required this.season,
  });

  @override
  State<LeagueTopAssistsSection> createState() => _LeagueTopAssistsSectionState();
}

class _LeagueTopAssistsSectionState extends State<LeagueTopAssistsSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<LeagueTopAssistsController>(
          instanceName: '${widget.leagueId}',
        )
        .getTopAssists(
          leagueId: widget.leagueId,
          season: widget.season,
        );
  }

  @override
  Widget build(BuildContext context) {
    final topAssistsState = watchIt<LeagueTopAssistsController>(
      instanceName: '${widget.leagueId}',
    ).value;

    return Animate(
      key: ValueKey(topAssistsState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      child: switch (topAssistsState) {
        Initial() => const BalunError(
            error: "Initial state, this shouldn't happen",
            isSmall: true,
          ),
        Loading() => LeagueTopAssistsLoading(),
        Empty() => const BalunEmpty(
            message: 'There are no top assists',
            isSmall: true,
          ),
        Error() => BalunError(
            error: (topAssistsState as Error).error ?? 'Generic top assists error',
            isSmall: true,
          ),
        Success() => LeagueTopAssistsContent(
            assists: (topAssistsState as Success).data,
            season: widget.season ?? DateTime.now().year,
          ),
      },
    );
  }
}
