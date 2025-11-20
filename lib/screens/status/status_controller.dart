import 'package:flutter/material.dart';

import '../../models/status/status_inner_response.dart';
import '../../services/api_service.dart';
import '../../services/logger_service.dart';
import '../../util/state.dart';

class StatusController extends ValueNotifier<BalunState<StatusInnerResponse>> {
  final LoggerService logger;
  final APIService api;

  StatusController({
    required this.logger,
    required this.api,
  }) : super(Initial());

  ///
  /// METHODS
  ///

  Future<void> getStatus() async {
    value = Loading();

    final response = await api.getStatus();

    /// Successful request
    if (response.statusResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.statusResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.statusResponse!.errors!.toString(),
        );
      }
      /// Response is not null, update to success state
      else if (response.statusResponse!.response != null) {
        value = Success(
          data: response.statusResponse!.response!,
        );
      }
      /// Response is null, update to empty state
      else {
        value = Empty();
      }
    }

    /// Failed request
    if (response.statusResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
