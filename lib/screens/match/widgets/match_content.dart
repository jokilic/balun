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
        Initial() => const BalunError(
            error: "Initial state, this shouldn't happen",
          ),
        Loading() => MatchLoading(),
        Empty() => const BalunEmpty(
            message: 'There is no match',
          ),
        Error() => BalunError(
            error: (matchState as Error).error ?? 'Generic match error',
          ),
        Success() => MatchSuccess(
            match: (matchState as Success).data,
          ),
      };
}
