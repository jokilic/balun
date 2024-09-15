import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/squads/player/player.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class TeamPlayersController extends ValueNotifier<BalunState<List<Player>>> {
  final LoggerService logger;
  final APIService api;

  TeamPlayersController({
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

  Future<void> getPlayersFromTeam({
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

    final response = await api.getPlayersFromTeam(
      teamId: teamId!,
    );

    /// Successful request
    if (response.squadsResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.squadsResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.squadsResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.squadsResponse!.response?.isNotEmpty ?? false) {
        fetched = true;
        value = Success(
          data: response.squadsResponse!.response!.first.players ?? [],
        );
      }

      /// Response is null, update to empty state
      else {
        fetched = true;
        value = Empty();
      }
    }

    /// Failed request
    if (response.squadsResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
