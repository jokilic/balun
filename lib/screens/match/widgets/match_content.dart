import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../util/state.dart';
import '../../../widgets/balun_empty.dart';
import '../../../widgets/balun_error.dart';
import 'match_loading.dart';
import 'match_success.dart';

class MatchContent extends StatelessWidget {
  final BalunState matchState;

  const MatchContent({
    required this.matchState,
  });

  @override
  Widget build(BuildContext context) => switch (matchState) {
        Initial() => BalunError(
            error: 'initialState'.tr(),
          ),
        Loading() => MatchLoading(),
        Empty() => BalunEmpty(
            message: 'matchEmptyState'.tr(),
          ),
        Error() => BalunError(
            error: (matchState as Error).error ?? 'matchErrorState'.tr(),
          ),
        Success() => MatchSuccess(
            match: (matchState as Success).data,
          ),
      };
}
