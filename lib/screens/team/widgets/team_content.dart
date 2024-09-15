import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../util/state.dart';
import '../../../widgets/balun_empty.dart';
import '../../../widgets/balun_error.dart';
import 'team_loading.dart';
import 'team_success.dart';

class TeamContent extends StatelessWidget {
  final BalunState teamState;

  const TeamContent({
    required this.teamState,
  });

  @override
  Widget build(BuildContext context) => switch (teamState) {
        Initial() => BalunError(
            error: 'initialState'.tr(),
          ),
        Loading() => TeamLoading(),
        Empty() => BalunEmpty(
            message: 'teamEmptyState'.tr(),
          ),
        Error() => BalunError(
            error: (teamState as Error).error ?? 'teamErrorState'.tr(),
          ),
        Success() => TeamSuccess(
            team: (teamState as Success).data,
          ),
      };
}
