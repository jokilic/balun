// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/material.dart';

import '../../../models/players/statistic/statistic_team.dart';
import '../../../services/logger_service.dart';

class PlayerCurrentTeamController extends ValueNotifier<StatisticTeam?> {
  final LoggerService logger;

  PlayerCurrentTeamController({
    required this.logger,
  }) : super(null);

  ///
  /// METHODS
  ///

  void updateState(StatisticTeam? newTeam) => value = newTeam;
}
