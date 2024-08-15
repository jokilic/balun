import 'package:flutter/material.dart';

import '../../../models/leagues/league_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class TeamLeaguesController extends ValueNotifier<BalunState<List<LeagueResponse>>> {
  final LoggerService logger;
  final APIService api;

  TeamLeaguesController({
    required this.logger,
    required this.api,
  }) : super(Initial());

  ///
  /// VARIABLES
  ///

  var fetched = false;

  ///
  /// METHODS
  ///

  Future<void> getLeaguesFromTeam({
    required int? teamId,
  }) async {
    if (teamId == null) {
      value = Error(
        error: 'Passed teamId is null',
      );
    }

    if (fetched) {
      return;
    }

    value = Loading();

    final response = await api.getLeaguesFromTeam(
      teamId: teamId!,
    );

    /// Successful request
    if (response.leaguesResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.leaguesResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.leaguesResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.leaguesResponse!.response?.isNotEmpty ?? false) {
        fetched = true;
        value = Success(
          data: response.leaguesResponse!.response!,
        );
      }

      /// Response is null, update to empty state
      else {
        fetched = true;
        value = Empty();
      }
    }

    /// Failed request
    if (response.leaguesResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
