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

class CoachTrophiesSection extends StatefulWidget {
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
        Initial() => const BalunEmpty(
            message: "Initial state, this shouldn't happen",
          ),
        Loading() => CoachTrophiesLoading(),
        Empty() => const BalunEmpty(
            message: 'There are no coach trophies',
            verticalPadding: 0,
          ),
        Error() => BalunError(
            error: (trophiesState as Error).error ?? 'Generic coach trophies error',
          ),
        Success() => CoachTrophiesContent(
            trophies: (trophiesState as Success).data,
          ),
      },
    );
  }
}
