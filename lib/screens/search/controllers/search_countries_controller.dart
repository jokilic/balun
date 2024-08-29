import 'package:flutter/material.dart';

import '../../../models/search/search_countries/search_countries_inner_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class SearchCountriesController extends ValueNotifier<BalunState<List<SearchCountriesInnerResponse>>> {
  final LoggerService logger;
  final APIService api;

  SearchCountriesController({
    required this.logger,
    required this.api,
  }) : super(Initial());

  ///
  /// METHODS
  ///

  Future<void> searchCountries({
    required String searchValue,
  }) async {
    value = Loading();

    final response = await api.searchCountries(
      searchValue: searchValue,
    );

    /// Successful request
    if (response.searchCountriesResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.searchCountriesResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.searchCountriesResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.searchCountriesResponse!.response?.isNotEmpty ?? false) {
        value = Success(
          data: response.searchCountriesResponse!.response!,
        );
      }

      /// Response is null, update to empty state
      else {
        value = Empty();
      }
    }

    /// Failed request
    if (response.searchCountriesResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
