import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../../../widgets/balun_loader.dart';
import '../../../../controllers/player_statistics_controller.dart';
import 'player_statistics_content.dart';

class PlayerStatisticsSection extends WatchingStatefulWidget {
  final int? playerId;
  final int? season;

  const PlayerStatisticsSection({
    required this.playerId,
    required this.season,
  });

  @override
  State<PlayerStatisticsSection> createState() => _PlayerStatisticsSectionState();
}

class _PlayerStatisticsSectionState extends State<PlayerStatisticsSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<PlayerStatisticsController>(
          instanceName: '${widget.playerId}',
        )
        .getPlayerStatistics(
          playerId: widget.playerId,
          season: widget.season,
        );
  }

  @override
  Widget build(BuildContext context) {
    final statisticsState = watchIt<PlayerStatisticsController>(
      instanceName: '${widget.playerId}',
    ).value;

    return Animate(
      key: ValueKey(statisticsState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      // TODO: Implement all states
      child: switch (statisticsState) {
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
            error: (statisticsState as Error).error ?? 'Generic player statistics error',
          ),
        Success() => PlayerStatisticsContent(
            statistics: (statisticsState as Success).data,
            season: widget.season ?? DateTime.now().year,
          ),
      },
    );
  }
}
