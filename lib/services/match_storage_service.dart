import 'package:flutter/material.dart';

import '../models/matches/favorite_match.dart';
import '../util/dependencies.dart';
import 'hive_service.dart';
import 'logger_service.dart';

class MatchStorageService extends ValueNotifier<List<FavoriteMatch>> {
  final LoggerService logger;
  final List<FavoriteMatch> hiveMatches;

  MatchStorageService({
    required this.logger,
    required this.hiveMatches,
  }) : super(hiveMatches);

  ///
  /// METHODS
  ///

  Future<void> toggleMatch({required FavoriteMatch? passedMatch}) async {
    if (passedMatch == null) {
      return;
    }

    /// Check if match exists in storage
    final matchExists = value.any(
      (match) => match.matchId == passedMatch.matchId,
    );

    /// Match exists, remove it from state & storage
    if (matchExists) {
      value = List.from(
        value..removeWhere(
          (match) => match.matchId == passedMatch.matchId,
        ),
      );
    }
    /// Match doesn't exist, add it to state & storage
    else {
      final newList = List<FavoriteMatch>.from(value);

      /// Find the `id` of the closest `match`
      var closestIndex = -1;
      var smallestDiff = -1;

      for (var i = 0; i < newList.length; i++) {
        final diff = ((newList[i].matchId ?? 0) - (passedMatch.matchId ?? 0)).abs();

        if (smallestDiff == -1 || diff < smallestDiff) {
          smallestDiff = diff;
          closestIndex = i;
        }
      }

      /// Insert after the closest `match`
      if (closestIndex != -1) {
        newList.insert(closestIndex + 1, passedMatch);
      }
      /// List is empty, just add to the end
      else {
        newList.add(passedMatch);
      }

      value = newList;
    }

    /// Update storage
    await getIt.get<HiveService>().writeMatches(value);
  }

  /// Triggered when reordering matches in [FixturesFavoriteDialog]
  Future<void> reorderMatches(int oldIndex, int newIndex) async {
    /// Modify `value`
    final item = value.removeAt(oldIndex);
    value = List.from(value..insert(newIndex, item));

    /// Update storage
    await getIt.get<HiveService>().writeMatches(value);
  }
}
