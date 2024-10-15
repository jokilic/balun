import 'package:flutter/material.dart';

import '../../../models/players/player_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class PlayerController extends ValueNotifier<BalunState<PlayerResponse>> {
  final LoggerService logger;
  final APIService api;

  PlayerController({
    required this.logger,
    required this.api,
  }) : super(Initial());

  ///
  /// METHODS
  ///

  Future<void> getPlayer({
    required int playerId,
    required String season,
  }) async {
    value = Loading();

    final response = await api.getPlayer(
      playerId: playerId,
      season: season,
    );

    /// Successful request
    if (response.playersResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.playersResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.playersResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.playersResponse!.response?.isNotEmpty ?? false) {
        value = Success(
          data: response.playersResponse!.response!.first,
        );
      }

      /// Response is null, update to empty state
      else {
        value = Empty();
      }
    }

    /// Failed request
    if (response.playersResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
