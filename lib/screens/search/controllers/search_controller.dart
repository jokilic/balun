import 'package:flutter/material.dart';

import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class SearchController extends ValueNotifier<BalunState<bool>> {
  final LoggerService logger;
  final APIService api;

  SearchController({
    required this.logger,
    required this.api,
  }) : super(Initial());

  ///
  /// METHODS
  ///

  // Future<void> getLeague({
  //   required int leagueId,
  // }) async {
  //   value = Loading();

  //   final response = await api.getLeague(
  //     leagueId: leagueId,
  //   );

  //   /// Successful request
  //   if (response.leaguesResponse != null && response.error == null) {
  //     /// Errors exist, update to error state
  //     if (response.leaguesResponse!.errors?.isNotEmpty ?? false) {
  //       value = Error(
  //         error: response.leaguesResponse!.errors!.toString(),
  //       );
  //     }

  //     /// Response is not null, update to success state
  //     else if (response.leaguesResponse!.response?.isNotEmpty ?? false) {
  //       value = Success(
  //         data: response.leaguesResponse!.response!.first,
  //       );
  //     }

  //     /// Response is null, update to empty state
  //     else {
  //       value = Empty();
  //     }
  //   }

  //   /// Failed request
  //   if (response.leaguesResponse == null && response.error != null) {
  //     /// Error is not null, update to error state
  //     value = Error(
  //       error: response.error,
  //     );
  //   }
  // }
}
