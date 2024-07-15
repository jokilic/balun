import 'package:flutter/material.dart';

import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import 'team_state.dart';

class TeamController extends ValueNotifier<TeamState> {
  final LoggerService logger;
  final APIService api;

  TeamController({
    required this.logger,
    required this.api,
  }) : super(TeamStateInitial());

  ///
  /// METHODS
  ///

  Future<void> getTeam({
    required int teamId,
  }) async {
    value = TeamStateLoading();

    final response = await api.getTeam(
      teamId: teamId,
    );

    /// Successful request
    if (response.teamsResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.teamsResponse!.errors?.isNotEmpty ?? false) {
        value = TeamStateError(
          error: response.teamsResponse!.errors?.map((error) => error.bug).toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.teamsResponse!.response != null) {
        value = TeamStateSuccess(
          team: response.teamsResponse!.response!.first,
        );
      }

      /// Response is null, update to error state
      else {
        value = TeamStateError(
          error: 'Team response is null',
        );
      }
    }

    /// Failed request
    if (response.teamsResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = TeamStateError(
        error: response.error,
      );
    }
  }
}
