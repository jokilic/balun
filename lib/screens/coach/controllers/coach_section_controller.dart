import 'package:flutter/material.dart';

import '../../../models/sections/coach_section.dart';
import '../../../services/logger_service.dart';

class CoachSectionController extends ValueNotifier<CoachSection> {
  final LoggerService logger;

  CoachSectionController({
    required this.logger,
  }) : super(CoachSection(coachSectionEnum: CoachSectionEnum.info));

  ///
  /// METHODS
  ///

  void updateState(CoachSection newSection) {
    if (value != newSection) {
      value = newSection;
    }
  }
}
