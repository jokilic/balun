import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../models/sections/team_section.dart';
import '../../../services/logger_service.dart';
import '../../../util/scrollable_titles.dart';

class TeamSectionController extends ValueNotifier<TeamSection> implements Disposable {
  final LoggerService logger;

  TeamSectionController({
    required this.logger,
  }) : super(TeamSection(teamSectionEnum: TeamSectionEnum.stadium)) {
    controller = PageController(
      initialPage: TeamSectionEnum.stadium.index,
      viewportFraction: viewportFraction,
    );

    animateScrollableTitles(
      scrollController: controller,
      viewportFraction: viewportFraction,
      targetPage: TeamSectionEnum.stadium.index,
    );
  }

  @override
  FutureOr onDispose() {
    controller.dispose();
  }

  ///
  /// VARIABLES
  ///

  final viewportFraction = 0.4;

  late final ScrollController controller;

  ///
  /// METHODS
  ///

  void updateState(TeamSection newSection) {
    if (value != newSection) {
      value = newSection;

      animateScrollableTitles(
        scrollController: controller,
        viewportFraction: viewportFraction,
        targetPage: newSection.teamSectionEnum.index,
      );
    }
  }
}
