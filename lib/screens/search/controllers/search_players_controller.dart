import 'package:flutter/material.dart';

import '../../../models/search/search_players/search_player_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class SearchPlayersController extends ValueNotifier<BalunState<List<SearchPlayerResponse>>> {
  final LoggerService logger;
  final APIService api;

  SearchPlayersController({
    required this.logger,
    required this.api,
  }) : super(Initial());

  ///
  /// METHODS
  ///

  Future<void> searchPlayers({
    required String searchValue,
  }) async {
    value = Loading();

    final response = await api.searchPlayers(
      searchValue: searchValue,
    );

    /// Successful request
    if (response.searchPlayersResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.searchPlayersResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.searchPlayersResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.searchPlayersResponse!.response?.isNotEmpty ?? false) {
        value = Success(
          data: response.searchPlayersResponse!.response!,
        );
      }

      /// Response is null, update to empty state
      else {
        value = Empty();
      }
    }

    /// Failed request
    if (response.searchPlayersResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
