import 'package:flutter/material.dart';

import '../../../models/sections/team_section.dart';
import '../../../services/logger_service.dart';
import '../../../util/scrollable.dart';

class TeamSectionController extends ValueNotifier<TeamSection> {
  final LoggerService logger;

  TeamSectionController({
    required this.logger,
  }) : super(TeamSection(teamSectionEnum: TeamSectionEnum.stadium)) {
    itemKeys = {
      for (final section in TeamSectionEnum.values) section.index: GlobalKey(),
    };
  }

  ///
  /// VARIABLES
  ///

  late final Map<int, GlobalKey> itemKeys;

  ///
  /// METHODS
  ///

  void updateState(TeamSection newSection) {
    if (value != newSection) {
      value = newSection;

      animateActiveSectionTitle(
        itemKeys: itemKeys,
        newSectionIndex: newSection.teamSectionEnum.index,
      );
    }
  }
}
