import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/sidelined/sidelined_inner_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class PlayerSidelinedController extends ValueNotifier<BalunState<List<SidelinedInnerResponse>>> {
  final LoggerService logger;
  final APIService api;

  PlayerSidelinedController({
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

  Future<void> getPlayerSidelined({
    required int? playerId,
  }) async {
    if (playerId == null) {
      value = Error(
        error: 'playerIdNull'.tr(),
      );
    }

    if (fetched) {
      return;
    }

    value = Loading();

    final response = await api.getSidelinedFromPlayer(
      playerId: playerId!,
    );

    /// Successful request
    if (response.sidelinedResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.sidelinedResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.sidelinedResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.sidelinedResponse!.response?.isNotEmpty ?? false) {
        fetched = true;
        value = Success(
          data: response.sidelinedResponse!.response!,
        );
      }

      /// Response is null, update to empty state
      else {
        fetched = true;
        value = Empty();
      }
    }

    /// Failed request
    if (response.sidelinedResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
