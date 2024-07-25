import 'package:flutter/material.dart';

import '../../../models/fixtures/fixture_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class MatchController extends ValueNotifier<BalunState<FixtureResponse>> {
  final LoggerService logger;
  final APIService api;

  MatchController({
    required this.logger,
    required this.api,
  }) : super(Initial());

  ///
  /// METHODS
  ///

  Future<void> getMatch({
    required int matchId,
  }) async {
    value = Loading();

    final response = await api.getMatch(
      matchId: matchId,
    );

    /// Successful request
    if (response.fixturesResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.fixturesResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.fixturesResponse!.errors?.map((error) => error.bug).toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.fixturesResponse!.response != null) {
        value = Success(
          data: response.fixturesResponse!.response!.first,
        );
      }

      /// Response is null, update to error state
      else {
        value = Error(
          error: 'Match response is null',
        );
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
