import 'package:flutter/material.dart';

import '../../../models/sections/team_section.dart';
import '../../../services/logger_service.dart';

class TeamSectionController extends ValueNotifier<TeamSection> {
  final LoggerService logger;

  TeamSectionController({
    required this.logger,
  }) : super(TeamSection(teamSectionEnum: TeamSectionEnum.stadium));

  ///
  /// METHODS
  ///

  void updateState(TeamSection newSection) {
    if (value != newSection) {
      value = newSection;
    }
  }
}
