import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/player_teams/player_team_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class PlayerTeamsController extends ValueNotifier<BalunState<List<PlayerTeamResponse>>> {
  final LoggerService logger;
  final APIService api;

  PlayerTeamsController({
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

  Future<void> getPlayerTeams({
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

    final response = await api.getPlayerTeams(
      playerId: playerId!,
    );

    /// Successful request
    if (response.playerTeamsResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.playerTeamsResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.playerTeamsResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.playerTeamsResponse!.response?.isNotEmpty ?? false) {
        fetched = true;
        value = Success(
          data: response.playerTeamsResponse!.response!,
        );
      }

      /// Response is null, update to empty state
      else {
        fetched = true;
        value = Empty();
      }
    }

    /// Failed request
    if (response.playerTeamsResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
