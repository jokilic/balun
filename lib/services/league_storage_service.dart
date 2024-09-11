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
    final leagueExists = value.any((league) => league.id == passedLeague.id);

    /// League exists, remove it from state & storage
    if (leagueExists) {
      value = List.from(value..removeWhere((league) => league.id == passedLeague.id));
    }

    /// League doesn't exist, add it to state & storage
    else {
      value = List.from(value..add(passedLeague));
    }

    /// Update storage
    await getIt.get<HiveService>().writeLeagues(value);
  }
}
