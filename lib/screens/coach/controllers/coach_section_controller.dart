import 'package:flutter/material.dart';

import '../../../models/sections/coach_section.dart';
import '../../../services/logger_service.dart';
import '../../../util/scrollable.dart';

class CoachSectionController extends ValueNotifier<CoachSection> {
  final LoggerService logger;

  CoachSectionController({
    required this.logger,
  }) : super(CoachSection(coachSectionEnum: CoachSectionEnum.info)) {
    itemKeys = {
      for (final section in CoachSectionEnum.values) section.index: GlobalKey(),
    };
  }

  ///
  /// VARIABLES
  ///

  late final Map<int, GlobalKey> itemKeys;

  ///
  /// METHODS
  ///

  void updateState(CoachSection newSection) {
    if (value != newSection) {
      value = newSection;

      animateActiveSectionTitle(
        itemKeys: itemKeys,
        newSectionIndex: newSection.coachSectionEnum.index,
      );
    }
  }
}
