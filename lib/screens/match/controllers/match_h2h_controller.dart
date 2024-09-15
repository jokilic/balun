import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/fixtures/fixture_response.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/state.dart';

class MatchHead2HeadController extends ValueNotifier<BalunState<List<FixtureResponse>>> {
  final LoggerService logger;
  final APIService api;

  MatchHead2HeadController({
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

  Future<void> getHead2Head({
    required int? homeTeamId,
    required int? awayTeamId,
  }) async {
    if (homeTeamId == null || awayTeamId == null) {
      value = Error(
        error: 'homeTeamIdOrAwayTeamIdNull'.tr(),
      );
    }

    if (fetched) {
      return;
    }

    value = Loading();

    final response = await api.getHead2Head(
      homeTeamId: homeTeamId!,
      awayTeamId: awayTeamId!,
    );

    /// Successful request
    if (response.head2HeadResponse != null && response.error == null) {
      /// Errors exist, update to error state
      if (response.head2HeadResponse!.errors?.isNotEmpty ?? false) {
        value = Error(
          error: response.head2HeadResponse!.errors!.toString(),
        );
      }

      /// Response is not null, update to success state
      else if (response.head2HeadResponse!.response?.firstOrNull?.league != null) {
        fetched = true;
        value = Success(
          data: response.head2HeadResponse!.response!,
        );
      }

      /// Response is null, update to empty state
      else {
        fetched = true;
        value = Empty();
      }
    }

    /// Failed request
    if (response.head2HeadResponse == null && response.error != null) {
      /// Error is not null, update to error state
      value = Error(
        error: response.error,
      );
    }
  }
}
