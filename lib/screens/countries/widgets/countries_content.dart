import 'package:flutter/material.dart';

import '../../../util/state.dart';
import '../../../widgets/balun_error.dart';
import '../../../widgets/balun_loader.dart';
import 'countries_success.dart';

class CountriesContent extends StatelessWidget {
  final BalunState countriesState;

  const CountriesContent({
    required this.countriesState,
  });

// TODO: Implement all states
  @override
  Widget build(BuildContext context) => switch (countriesState) {
        Initial() => Container(color: Colors.green),
        Loading() => const Center(child: BalunLoader()),
        Empty() => Container(color: Colors.grey),
        Error() => BalunError(
            error: (countriesState as Error).error ?? 'Generic countries error',
          ),
        Success() => CountriesSuccess(
            countries: (countriesState as Success).data,
          ),
      };
}
