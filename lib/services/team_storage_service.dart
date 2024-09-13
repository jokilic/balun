import 'package:flutter/material.dart';

import '../models/teams/team/team.dart';
import '../util/dependencies.dart';
import 'hive_service.dart';
import 'logger_service.dart';

class TeamStorageService extends ValueNotifier<List<Team>> {
  ///
  /// CONSTRUCTOR
  ///

  final LoggerService logger;
  final List<Team> hiveTeams;

  TeamStorageService({
    required this.logger,
    required this.hiveTeams,
  }) : super(hiveTeams);

  ///
  /// METHODS
  ///

  Future<void> toggleTeam({required Team? passedTeam}) async {
    if (passedTeam == null) {
      return;
    }

    /// Check if team exists in storage
    final teamExists = value.any((team) => team.id == passedTeam.id);

    /// Team exists, remove it from state & storage
    if (teamExists) {
      value = List.from(value..removeWhere((team) => team.id == passedTeam.id));
    }

    /// Team doesn't exist, add it to state & storage
    else {
      value = List.from(value..add(passedTeam));
    }

    /// Update storage
    await getIt.get<HiveService>().writeTeams(value);
  }
}
