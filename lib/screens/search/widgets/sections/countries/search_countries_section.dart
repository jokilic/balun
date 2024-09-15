import 'package:easy_localization/easy_localization.dart';
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
      Initial() => BalunEmpty(
          message: 'searchCountriesInitialState'.tr(),
          smallMessage: 'searchSmallText'.tr(),
        ),
      Loading() => SearchCountriesLoading(),
      Empty() => BalunEmpty(
          message: 'searchCountriesEmptyState'.tr(),
          smallMessage: 'searchSmallText'.tr(),
        ),
      Error() => BalunError(
          error: (searchCountriesState as Error).error ?? 'searchCountriesErrorState'.tr(),
        ),
      Success() => SearchCountriesSuccess(
          countries: (searchCountriesState as Success).data,
        ),
    };
  }
}
