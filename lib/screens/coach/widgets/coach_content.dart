import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../util/state.dart';
import '../../../widgets/balun_empty.dart';
import '../../../widgets/balun_error.dart';
import 'coach_loading.dart';
import 'coach_success.dart';

class CoachContent extends StatelessWidget {
  final BalunState coachState;

  const CoachContent({
    required this.coachState,
  });

  @override
  Widget build(BuildContext context) => switch (coachState) {
        Initial() => BalunError(
            error: 'initialState'.tr(),
          ),
        Loading() => CoachLoading(),
        Empty() => BalunEmpty(
            message: 'coachEmptyState'.tr(),
          ),
        Error() => BalunError(
            error: (coachState as Error).error ?? 'coachErrorState'.tr(),
          ),
        Success() => CoachSuccess(
            coach: (coachState as Success).data,
          ),
      };
}
