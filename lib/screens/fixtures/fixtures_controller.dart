import 'package:flutter/material.dart';

import '../../models/fixtures/fixture_response.dart';
import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import '../../util/state.dart';

class FixturesController extends ValueNotifier<BalunState<List<FixtureResponse>>> {
  final LoggerService logger;
  final APIService api;

  FixturesController({
    required this.logger,
    required this.api,
  }) : super(Initial());

  ///
  /// METHODS
  ///

  Future<void> getFixtures() async {
    value = Loading();

    final response = await api.getFixtures();

    /// Successful request
    if (response.fixturesResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.fixturesResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.fixturesResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.fixturesResponse!.response?.isNotEmpty ?? false) {
        value = Success(
          data: response.fixturesResponse!.response!,
        );
      }

      /// Response is null, update to empty state
      else {
        value = Empty();
      }
    }

    /// Failed request
    if (response.fixturesResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
