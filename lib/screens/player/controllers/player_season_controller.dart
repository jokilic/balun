import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../constants.dart';
import '../../../models/player_section.dart';
import '../../../services/api_service.dart';
import '../../../services/logger_service.dart';
import '../../../util/dependencies.dart';
import 'player_section_controller.dart';
import 'player_statistics_controller.dart';

class PlayerSeasonController extends ValueNotifier<int> implements Disposable {
  final LoggerService logger;
  final APIService api;
  final PlayerSectionController section;
  final int playerId;
  final int initialSeason;

  PlayerSeasonController({
    required this.logger,
    required this.api,
    required this.section,
    required this.playerId,
    required this.initialSeason,
  }) : super(initialSeason) {
    const viewportFraction = 0.4;

    controller = PageController(
      initialPage: initialSeason,
      viewportFraction: viewportFraction,
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final pageOffset = initialSeason * viewportFraction;
        const centeringOffset = (1 - viewportFraction) / 2;

        controller
            .animateToPage(
              initialSeason,
              duration: BalunConstants.animationDuration,
              curve: Curves.easeIn,
            )
            .then(
              (_) => controller.animateTo(
                (pageOffset + centeringOffset) * controller.position.viewportDimension,
                duration: BalunConstants.animationDuration,
                curve: Curves.easeIn,
              ),
            );
      },
    );
  }

  @override
  FutureOr onDispose() {
    controller.dispose();
  }

  ///
  /// VARIABLES
  ///

  late final PageController controller;

  ///
  /// METHODS
  ///

  void updateState(int? newSeason) {
    if (newSeason != null && value != newSeason) {
      /// Set state to new value
      value = newSeason;

      /// Fetch new data, depending on active section
      switch (section.value) {
        ///
        /// STATISTICS
        ///
        case PlayerSection(playerSectionEnum: PlayerSectionEnum.statistics):
          getIt
              .get<PlayerStatisticsController>(
                instanceName: '$playerId',
              )
              .getPlayerStatistics(
                playerId: playerId,
                season: newSeason,
              );
          break;
      }
    }
  }
}
