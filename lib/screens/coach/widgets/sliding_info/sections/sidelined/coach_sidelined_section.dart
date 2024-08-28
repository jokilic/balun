import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../../constants.dart';
import '../../../../../../util/dependencies.dart';
import '../../../../../../util/state.dart';
import '../../../../../../widgets/balun_empty.dart';
import '../../../../../../widgets/balun_error.dart';
import '../../../../controllers/coach_sidelined_controller.dart';
import 'coach_sidelined_content.dart';
import 'coach_sidelined_loading.dart';

class CoachSidelinedSection extends StatefulWidget {
  final int? coachId;

  const CoachSidelinedSection({
    required this.coachId,
  });

  @override
  State<CoachSidelinedSection> createState() => _CoachSidelinedSectionState();
}

class _CoachSidelinedSectionState extends State<CoachSidelinedSection> {
  @override
  void initState() {
    super.initState();
    getIt
        .get<CoachSidelinedController>(
          instanceName: '${widget.coachId}',
        )
        .getCoachSidelined(
          coachId: widget.coachId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final sidelinedState = watchIt<CoachSidelinedController>(
      instanceName: '${widget.coachId}',
    ).value;

    return Animate(
      key: ValueKey(sidelinedState),
      effects: const [
        FadeEffect(
          curve: Curves.easeIn,
          duration: BalunConstants.animationDuration,
        ),
      ],
      child: switch (sidelinedState) {
        Initial() => const BalunEmpty(
            message: "Initial state, this shouldn't happen",
          ),
        Loading() => CoachSidelinedLoading(),
        Empty() => const BalunEmpty(
            message: 'There is no coach sidelined',
            verticalPadding: 0,
          ),
        Error() => BalunError(
            error: (sidelinedState as Error).error ?? 'Generic coach sidelined error',
          ),
        Success() => CoachSidelinedContent(
            sidelined: (sidelinedState as Success).data,
          ),
      },
    );
  }
}
