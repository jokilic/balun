import 'package:easy_localization/easy_localization.dart';
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
    Initial() => BalunError(
      error: 'initialState'.tr(),
    ),
    Loading() => CountriesLoading(),
    Empty() => BalunEmpty(
      message: 'countriesEmptyState'.tr(),
    ),
    Error() => BalunError(
      error: (countriesState as Error).error ?? 'countriesErrorState'.tr(),
    ),
    Success() => CountriesSuccess(
      countries: (countriesState as Success).data,
    ),
  };
}
