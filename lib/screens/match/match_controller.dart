import 'package:flutter/material.dart';

import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import 'match_state.dart';

class MatchController extends ValueNotifier<MatchState> {
  final LoggerService logger;
  final APIService api;

  MatchController({
    required this.logger,
    required this.api,
  }) : super(MatchStateInitial());

  ///
  /// METHODS
  ///

  Future<void> getMatch({
    required int matchId,
  }) async {
    value = MatchStateLoading();

    final response = await api.getMatch(
      matchId: matchId,
    );

    /// Successful request
    if (response.fixturesResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.fixturesResponse!.errors?.isNotEmpty ?? false) {
        value = MatchStateError(
          error: response.fixturesResponse!.errors?.map((error) => error.bug).toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.fixturesResponse!.response != null) {
        value = MatchStateSuccess(
          match: response.fixturesResponse!.response!.first,
        );
      }

      /// Response is null, update to error state
      else {
        value = MatchStateError(
          error: 'Match response is null',
        );
      }
    }

    /// Failed request
    if (response.fixturesResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = MatchStateError(
        error: response.error,
      );
    }
  }
}
