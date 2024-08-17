import 'package:flutter/material.dart';

import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import 'player_section_controller.dart';

class PlayerSeasonController extends ValueNotifier<int> {
  final LoggerService logger;
  final APIService api;
  final PlayerSectionController section;
  final int playerId;
  final int initialSeason;

  PlayerSeasonController({
    required this.logger,
    required this.api,
    required this.section,
    required this.playerId,
    required this.initialSeason,
  }) : super(initialSeason);

  ///
  /// METHODS
  ///

  void updateState(int? newSeason) {
    if (newSeason != null && value != newSeason) {
      /// Set state to new value
      value = newSeason;

      /// Fetch new data, depending on active section
      switch (section.value) {}
    }
  }
}
