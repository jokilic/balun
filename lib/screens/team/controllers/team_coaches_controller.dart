import 'package:flutter/material.dart';

import '../../../models/coaches/coach_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class TeamCoachesController extends ValueNotifier<BalunState<List<CoachResponse>>> {
  final LoggerService logger;
  final APIService api;

  TeamCoachesController({
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

  Future<void> getCoachesFromTeam({
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

    final response = await api.getCoachesFromTeam(
      teamId: teamId!,
    );

    /// Successful request
    if (response.coachesResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.coachesResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.coachesResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.coachesResponse!.response?.isNotEmpty ?? false) {
        fetched = true;
        value = Success(
          data: response.coachesResponse!.response!,
        );
      }

      /// Response is null, update to empty state
      else {
        fetched = true;
        value = Empty();
      }
    }

    /// Failed request
    if (response.coachesResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
