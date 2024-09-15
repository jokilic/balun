import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/player_trophies_controller.dart';
import 'player_trophies_content.dart';
import 'player_trophies_loading.dart';

class PlayerTrophiesSection extends WatchingStatefulWidget {
  final int? playerId;

  const PlayerTrophiesSection({
    required this.playerId,
  });

  @override
  State<PlayerTrophiesSection> createState() => _PlayerTrophiesSectionState();
}

class _PlayerTrophiesSectionState extends State<PlayerTrophiesSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<PlayerTrophiesController>(
          instanceName: '${widget.playerId}',
        )
        .getPlayerTrophies(
          playerId: widget.playerId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final trophiesState = watchIt<PlayerTrophiesController>(
      instanceName: '${widget.playerId}',
    ).value;

    return Animate(
      key: ValueKey(trophiesState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      child: switch (trophiesState) {
        Initial() => BalunError(
            error: 'initialState'.tr(),
            isSmall: true,
          ),
        Loading() => PlayerTrophiesLoading(),
        Empty() => BalunEmpty(
            message: 'playerTrophiesEmptyState'.tr(),
            isSmall: true,
          ),
        Error() => BalunError(
            error: (trophiesState as Error).error ?? 'playerTrophiesErrorState'.tr(),
            isSmall: true,
          ),
        Success() => PlayerTrophiesContent(
            trophies: (trophiesState as Success).data,
          ),
      },
    );
  }
}
