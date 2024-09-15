import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/coach_trophies_controller.dart';
import 'coach_trophies_content.dart';
import 'coach_trophies_loading.dart';

class CoachTrophiesSection extends WatchingStatefulWidget {
  final int? coachId;

  const CoachTrophiesSection({
    required this.coachId,
  });

  @override
  State<CoachTrophiesSection> createState() => _CoachTrophiesSectionState();
}

class _CoachTrophiesSectionState extends State<CoachTrophiesSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<CoachTrophiesController>(
          instanceName: '${widget.coachId}',
        )
        .getCoachTrophies(
          coachId: widget.coachId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final trophiesState = watchIt<CoachTrophiesController>(
      instanceName: '${widget.coachId}',
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
        Loading() => CoachTrophiesLoading(),
        Empty() => BalunEmpty(
            message: 'coachTrophiesEmptyState'.tr(),
            isSmall: true,
          ),
        Error() => BalunError(
            error: (trophiesState as Error).error ?? 'coachTrophiesErrorState'.tr(),
            isSmall: true,
          ),
        Success() => CoachTrophiesContent(
            trophies: (trophiesState as Success).data,
          ),
      },
    );
  }
}
