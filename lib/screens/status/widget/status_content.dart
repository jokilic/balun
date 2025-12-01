import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../util/state.dart';
import '../../../widgets/balun_empty.dart';
import '../../../widgets/balun_error.dart';
import 'status_loading.dart';
import 'status_success.dart';

class StatusContent extends StatelessWidget {
  final BalunState statusState;

  const StatusContent({
    required this.statusState,
  });

  @override
  Widget build(BuildContext context) => switch (statusState) {
    Initial() => BalunError(
      error: 'initialState'.tr(),
      hasBackButton: true,
    ),
    Loading() => StatusLoading(),
    Empty() => BalunEmpty(
      message: 'statusEmptyState'.tr(),
      hasBackButton: true,
    ),
    Error() => BalunError(
      error: (statusState as Error).error ?? 'statusErrorState'.tr(),
      hasBackButton: true,
    ),
    Success() => StatusSuccess(
      status: (statusState as Success).data,
    ),
  };
}
