import 'package:flutter/material.dart';

import '../../../models/match_section.dart';
import '../../../services/logger_service.dart';

class MatchSectionController extends ValueNotifier<MatchSection> {
  final LoggerService logger;

  MatchSectionController({
    required this.logger,
  }) : super(MatchSection(matchSectionEnum: MatchSectionEnum.info));

  ///
  /// METHODS
  ///

  void updateState(MatchSection newSection) {
    if (value != newSection) {
      value = newSection;
    }
  }
}
