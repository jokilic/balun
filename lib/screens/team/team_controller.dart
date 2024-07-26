import 'package:flutter/material.dart';

import '../../models/teams/team_response.dart';
import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import '../../util/state.dart';

class TeamController extends ValueNotifier<BalunState<TeamResponse>> {
  final LoggerService logger;
  final APIService api;

  TeamController({
    required this.logger,
    required this.api,
  }) : super(Initial());

  ///
  /// METHODS
  ///

  Future<void> getTeam({
    required int teamId,
  }) async {
    value = Loading();

    final response = await api.getTeam(
      teamId: teamId,
    );

    /// Successful request
    if (response.teamsResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.teamsResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.teamsResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.teamsResponse!.response?.isNotEmpty ?? false) {
        value = Success(
          data: response.teamsResponse!.response!.first,
        );
      }

      /// Response is null, update to error state
      else {
        value = Error(
          error: 'Team response is null',
        );
      }
    }

    /// Failed request
    if (response.teamsResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
