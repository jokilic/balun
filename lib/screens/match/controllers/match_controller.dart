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
    bool withLoadingState = true,
  }) async {
    if (withLoadingState) {
      value = Loading();
    }

    final response = await api.getMatch(
      matchId: matchId,
    );

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
        final data = response.fixturesResponse!.response!.first;

        value = Success(
          data: data,
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

  /// Triggered periodically
  /// Doesn't update `state`
  /// Fetches new `data` and updates if everything was successful
  Future<void> getPeriodicMatch({required int matchId}) async {
    /// Do the logic if we're already in [Success] `state`
    if (value is Success) {
      final response = await api.getMatch(
        matchId: matchId,
      );

      /// Successful request
      if (response.fixturesResponse != null && response.error == null) {
        /// Response is not null, update to success state
        if (response.fixturesResponse!.response?.isNotEmpty ?? false) {
          final data = response.fixturesResponse!.response!.first;

          value = Success(
            data: data,
          );
        }
      }
    }
  }
}
