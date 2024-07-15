import 'package:flutter/material.dart';

import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import 'fixtures_state.dart';

class FixturesController extends ValueNotifier<FixturesState> {
  final LoggerService logger;
  final APIService api;

  FixturesController({
    required this.logger,
    required this.api,
  }) : super(FixturesStateInitial())

  ///
  /// INIT
  ///

  {
    getFixtures();
  }

  ///
  /// METHODS
  ///

  Future<void> getFixtures() async {
    value = FixturesStateLoading();

    final response = await api.getFixtures();

    /// Successful request
    if (response.fixturesResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.fixturesResponse!.errors?.isNotEmpty ?? false) {
        value = FixturesStateError(
          error: response.fixturesResponse!.errors?.map((error) => error.bug).toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.fixturesResponse!.response != null) {
        value = FixturesStateSuccess(
          fixtures: response.fixturesResponse!.response!,
        );
      }

      /// Response is null, update to error state
      else {
        value = FixturesStateError(
          error: 'Fixtures response is null',
        );
      }
    }

    /// Failed request
    if (response.fixturesResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = FixturesStateError(
        error: response.error,
      );
    }
  }
}
