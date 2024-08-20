import 'package:flutter/material.dart';

import '../../../models/transfers/transfer/transfer.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class PlayerTransfersController extends ValueNotifier<BalunState<List<Transfer>>> {
  final LoggerService logger;
  final APIService api;

  PlayerTransfersController({
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

  Future<void> getPlayerTransfers({
    required int? playerId,
  }) async {
    if (playerId == null) {
      value = Error(
        error: 'Passed playerId is null',
      );
    }

    if (fetched) {
      return;
    }

    value = Loading();

    final response = await api.getTransfersFromPlayer(
      playerId: playerId!,
    );

    /// Successful request
    if (response.transfersResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.transfersResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.transfersResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.transfersResponse!.response?.firstOrNull?.transfers?.isNotEmpty ?? false) {
        fetched = true;
        value = Success(
          data: response.transfersResponse!.response!.first.transfers!,
        );
      }

      /// Response is null, update to empty state
      else {
        fetched = true;
        value = Empty();
      }
    }

    /// Failed request
    if (response.transfersResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
