import 'package:flutter/material.dart';

import '../../../util/state.dart';
import '../../../widgets/balun_empty.dart';
import '../../../widgets/balun_error.dart';
import 'countries_loading.dart';
import 'countries_success.dart';

class CountriesContent extends StatelessWidget {
  final BalunState countriesState;

  const CountriesContent({
    required this.countriesState,
  });

  @override
  Widget build(BuildContext context) => switch (countriesState) {
        Initial() => const BalunError(
            error: "Initial state, this shouldn't happen",
          ),
        Loading() => CountriesLoading(),
        Empty() => const BalunEmpty(
            message: 'There are no countries',
          ),
        Error() => BalunError(
            error: (countriesState as Error).error ?? 'Generic countries error',
          ),
        Success() => CountriesSuccess(
            countries: (countriesState as Success).data,
          ),
      };
}
