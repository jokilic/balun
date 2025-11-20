import 'package:flutter/material.dart';

import '../../../models/sections/player_section.dart';
import '../../../services/logger_service.dart';
import '../../../util/scrollable.dart';

class PlayerSectionController extends ValueNotifier<PlayerSection> {
  final LoggerService logger;

  PlayerSectionController({
    required this.logger,
  }) : super(PlayerSection(playerSectionEnum: PlayerSectionEnum.info)) {
    itemKeys = {
      for (final section in PlayerSectionEnum.values) section.index: GlobalKey(),
    };
  }

  ///
  /// VARIABLES
  ///

  late final Map<int, GlobalKey> itemKeys;

  ///
  /// METHODS
  ///

  void updateState(PlayerSection newSection) {
    if (value != newSection) {
      value = newSection;

      animateActiveSectionTitle(
        itemKeys: itemKeys,
        newSectionIndex: newSection.playerSectionEnum.index,
      );
    }
  }
}
