import 'package:flutter/material.dart';

import '../../../models/sections/league_section.dart';
import '../../../services/logger_service.dart';

class LeagueSectionController extends ValueNotifier<LeagueSection> {
  final LoggerService logger;

  LeagueSectionController({
    required this.logger,
  }) : super(LeagueSection(leagueSectionEnum: LeagueSectionEnum.teams));

  ///
  /// METHODS
  ///

  void updateState(LeagueSection newSection) {
    if (value != newSection) {
      value = newSection;
    }
  }
}
