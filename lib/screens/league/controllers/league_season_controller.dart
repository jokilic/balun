import 'package:flutter/material.dart';

import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';

class LeagueSeasonController extends ValueNotifier<int> {
  final LoggerService logger;
  final APIService api;
  final int initialSeason;

  LeagueSeasonController({
    required this.logger,
    required this.api,
    required this.initialSeason,
  }) : super(initialSeason);

  ///
  /// METHODS
  ///

  void updateState(int? newSeason) {
    if (newSeason != null && value != newSeason) {
      value = newSeason;
    }
  }
}
