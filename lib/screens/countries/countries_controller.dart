import 'package:flutter/material.dart';

import '../../models/countries/country_response.dart';
import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import '../../util/state.dart';

class CountriesController extends ValueNotifier<BalunState<List<CountryResponse>>> {
  final LoggerService logger;
  final APIService api;

  CountriesController({
    required this.logger,
    required this.api,
  }) : super(Initial());

  ///
  /// METHODS
  ///

  Future<void> getCountries() async {
    value = Loading();

    final response = await api.getCountries();

    /// Successful request
    if (response.countriesResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.countriesResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.countriesResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.countriesResponse!.response?.isNotEmpty ?? false) {
        value = Success(
          data: response.countriesResponse!.response!,
        );
      }

      /// Response is null, update to empty state
      else {
        value = Empty();
      }
    }

    /// Failed request
    if (response.countriesResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
