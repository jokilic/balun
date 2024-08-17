import 'package:flutter/material.dart';

import '../../../models/player_section.dart';
import '../../../services/logger_service.dart';

class PlayerSectionController extends ValueNotifier<PlayerSection> {
  final LoggerService logger;

  PlayerSectionController({
    required this.logger,
  }) : super(PlayerSection(playerSectionEnum: PlayerSectionEnum.info));

  ///
  /// METHODS
  ///

  void updateState(PlayerSection newSection) {
    if (value != newSection) {
      value = newSection;
    }
  }
}
