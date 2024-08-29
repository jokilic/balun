import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../../util/state.dart';
import '../../../../../widgets/balun_empty.dart';
import '../../../../../widgets/balun_error.dart';
import '../../../controllers/search_countries_controller.dart';
import 'search_countries_loading.dart';
import 'search_countries_success.dart';

class SearchCountriesSection extends WatchingWidget {
  @override
  Widget build(BuildContext context) {
    final searchCountriesState = watchIt<SearchCountriesController>(
      instanceName: 'search',
    ).value;

    return switch (searchCountriesState) {
      Initial() => const BalunEmpty(
          message: 'Search for countries',
        ),
      Loading() => SearchCountriesLoading(),
      Empty() => const BalunEmpty(
          message: 'There are no countries',
        ),
      Error() => BalunError(
          error: (searchCountriesState as Error).error ?? 'Generic search countries error',
        ),
      Success() => SearchCountriesSuccess(
          countries: (searchCountriesState as Success).data,
        ),
    };
  }
}
