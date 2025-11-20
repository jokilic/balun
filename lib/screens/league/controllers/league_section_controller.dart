import 'package:flutter/material.dart';

import '../../../models/sections/league_section.dart';
import '../../../services/logger_service.dart';
import '../../../util/scrollable.dart';

class LeagueSectionController extends ValueNotifier<LeagueSection> {
  final LoggerService logger;

  LeagueSectionController({
    required this.logger,
  }) : super(LeagueSection(leagueSectionEnum: LeagueSectionEnum.fixtures)) {
    itemKeys = {
      for (final section in LeagueSectionEnum.values) section.index: GlobalKey(),
    };
  }

  ///
  /// VARIABLES
  ///

  late final Map<int, GlobalKey> itemKeys;

  ///
  /// METHODS
  ///

  void updateState(LeagueSection newSection) {
    if (value != newSection) {
      value = newSection;

      animateActiveSectionTitle(
        itemKeys: itemKeys,
        newSectionIndex: newSection.leagueSectionEnum.index,
      );
    }
  }
}
