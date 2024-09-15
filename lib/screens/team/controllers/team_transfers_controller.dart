import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/transfers/transfer_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class TeamTransfersController extends ValueNotifier<BalunState<List<TransferResponse>>> {
  final LoggerService logger;
  final APIService api;

  TeamTransfersController({
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

  Future<void> getTransfersFromTeam({
    required int? teamId,
  }) async {
    if (teamId == null) {
      value = Error(
        error: 'teamIdNull'.tr(),
      );
    }

    if (fetched) {
      return;
    }

    value = Loading();

    final response = await api.getTransfersFromTeam(
      teamId: teamId!,
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
      else if (response.transfersResponse!.response?.isNotEmpty ?? false) {
        fetched = true;
        value = Success(
          data: response.transfersResponse!.response!,
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
