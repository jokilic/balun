import 'package:flutter/material.dart';

import '../../../models/coaches/coach_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class CoachController extends ValueNotifier<BalunState<CoachResponse>> {
  final LoggerService logger;
  final APIService api;

  CoachController({
    required this.logger,
    required this.api,
  }) : super(Initial());

  ///
  /// METHODS
  ///

  Future<void> getCoach({
    required int coachId,
  }) async {
    value = Loading();

    final response = await api.getCoach(
      coachId: coachId,
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
        value = Success(
          data: response.coachesResponse!.response!.first,
        );
      }

      /// Response is null, update to empty state
      else {
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
