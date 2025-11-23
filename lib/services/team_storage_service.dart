import 'package:flutter/material.dart';

import '../models/teams/team/team.dart';
import '../util/dependencies.dart';
import 'hive_service.dart';
import 'logger_service.dart';

class TeamStorageService extends ValueNotifier<List<Team>> {
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
      final newList = List<Team>.from(value);

      /// Find the `id` of the closest `team`
      var closestIndex = -1;
      var smallestDiff = -1;

      for (var i = 0; i < newList.length; i++) {
        final diff = ((newList[i].id ?? 0) - (passedTeam.id ?? 0)).abs();

        if (smallestDiff == -1 || diff < smallestDiff) {
          smallestDiff = diff;
          closestIndex = i;
        }
      }

      /// Insert after the closest `team`
      if (closestIndex != -1) {
        newList.insert(closestIndex + 1, passedTeam);
      }
      /// List is empty, just add to the end
      else {
        newList.add(passedTeam);
      }

      value = newList;
    }

    /// Update storage
    await getIt.get<HiveService>().writeTeams(value);
  }

  /// Triggered when reordering teams in [FixturesFavoriteDialog]
  Future<void> reorderTeams(int oldIndex, int newIndex) async {
    /// Modify `value`
    final item = value.removeAt(oldIndex);
    value = List.from(value..insert(newIndex, item));

    /// Update storage
    await getIt.get<HiveService>().writeTeams(value);
  }
}
