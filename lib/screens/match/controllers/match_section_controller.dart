import 'package:flutter/material.dart';

import '../../../models/sections/match_section.dart';
import '../../../services/logger_service.dart';

class MatchSectionController extends ValueNotifier<MatchSection> {
  final LoggerService logger;

  MatchSectionController({
    required this.logger,
  }) : super(
          MatchSection(
            matchSectionEnum: MatchSectionEnum.info,
          ),
        );

  ///
  /// METHODS
  ///

  void updateStateDependingOnMatchStatus({
    required String statusShort,
    required bool lineupExists,
    required bool eventsExist,
  }) {
    switch (statusShort.toUpperCase()) {
      ///
      /// MATCH NOT STARTED
      ///
      case 'TBD' || 'NS':
        updateState(
          MatchSection(
            matchSectionEnum: lineupExists ? MatchSectionEnum.lineups : MatchSectionEnum.info,
          ),
        );
        break;

      ///
      /// MATCH IN PROGRESS
      ///
      case '1H' || 'HT' || '2H' || 'ET':
        updateState(
          MatchSection(
            matchSectionEnum: MatchSectionEnum.events,
          ),
        );
        break;

      ///
      /// MATCH FINISHED
      ///
      case 'FT' || 'AET' || 'PEN':
        updateState(
          MatchSection(
            matchSectionEnum: eventsExist ? MatchSectionEnum.events : MatchSectionEnum.info,
          ),
        );
        break;
    }
  }

  void updateState(MatchSection newSection) {
    if (value != newSection) {
      value = newSection;
    }
  }
}
