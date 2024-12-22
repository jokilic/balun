import 'package:flutter/material.dart';

import '../models/leagues/league/league.dart';
import '../util/dependencies.dart';
import 'hive_service.dart';
import 'logger_service.dart';

class LeagueStorageService extends ValueNotifier<List<League>> {
  ///
  /// CONSTRUCTOR
  ///

  final LoggerService logger;
  final List<League> hiveLeagues;

  LeagueStorageService({
    required this.logger,
    required this.hiveLeagues,
  }) : super(hiveLeagues);

  ///
  /// METHODS
  ///

  Future<void> toggleLeague({required League? passedLeague}) async {
    if (passedLeague == null) {
      return;
    }

    /// Check if league exists in storage
    final leagueExists = value.any(
      (league) => league.id == passedLeague.id,
    );

    /// League exists, remove it from state & storage
    if (leagueExists) {
      value = List.from(
        value
          ..removeWhere(
            (league) => league.id == passedLeague.id,
          ),
      );
    }

    /// League doesn't exist, add it to state & storage
    else {
      final newList = List<League>.from(value);

      /// Find the `id` of the closest `league`
      var closestIndex = -1;
      var smallestDiff = -1;

      for (var i = 0; i < newList.length; i++) {
        final diff = ((newList[i].id ?? 0) - (passedLeague.id ?? 0)).abs();

        if (smallestDiff == -1 || diff < smallestDiff) {
          smallestDiff = diff;
          closestIndex = i;
        }
      }

      /// Insert after the closest `league`
      if (closestIndex != -1) {
        newList.insert(closestIndex + 1, passedLeague);
      }

      /// List is empty, just add to the end
      else {
        newList.add(passedLeague);
      }

      value = newList;
    }

    /// Update storage
    await getIt.get<HiveService>().writeLeagues(value);
  }

  /// Triggered when reordering leagues in [FixturesFavoriteDialog]
  Future<void> reorderLeagues(int oldIndex, int newIndex) async {
    /// Modify `value`
    final item = value.removeAt(oldIndex);
    value = List.from(value..insert(newIndex, item));

    /// Update storage
    await getIt.get<HiveService>().writeLeagues(value);
  }
}
