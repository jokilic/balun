import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/player_statistics_controller.dart';
import 'player_statistics_content.dart';
import 'player_statistics_loading.dart';

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
      child: switch (statisticsState) {
        Initial() => BalunError(
            error: 'initialState'.tr(),
            isSmall: true,
          ),
        Loading() => PlayerStatisticsLoading(),
        Empty() => BalunEmpty(
            message: 'playerStatisticsEmptyState'.tr(),
            isSmall: true,
          ),
        Error() => BalunError(
            error: (statisticsState as Error).error ?? 'playerStatisticsErrorState'.tr(),
            isSmall: true,
          ),
        Success() => PlayerStatisticsContent(
            statistics: (statisticsState as Success).data,
            season: widget.season ?? DateTime.now().year,
          ),
      },
    );
  }
}
