import 'package:flutter/material.dart';

import '../../../models/search/search_coaches/search_coach_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class SearchCoachesController extends ValueNotifier<BalunState<List<SearchCoachResponse>>> {
  final LoggerService logger;
  final APIService api;

  SearchCoachesController({
    required this.logger,
    required this.api,
  }) : super(Initial());

  ///
  /// METHODS
  ///

  Future<void> searchCoaches({
    required String searchValue,
  }) async {
    value = Loading();

    final response = await api.searchCoaches(
      searchValue: searchValue,
    );

    /// Successful request
    if (response.searchCoachesResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.searchCoachesResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.searchCoachesResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.searchCoachesResponse!.response?.isNotEmpty ?? false) {
        value = Success(
          data: response.searchCoachesResponse!.response!,
        );
      }

      /// Response is null, update to empty state
      else {
        value = Empty();
      }
    }

    /// Failed request
    if (response.searchCoachesResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
