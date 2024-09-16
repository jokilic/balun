import 'package:flutter/material.dart';

import '../models/fixtures/fixture_response.dart';
import '../models/fixtures/league/league.dart';
import '../util/dependencies.dart';
import '../util/fixtures.dart';
import 'league_storage_service.dart';
import 'logger_service.dart';
import 'team_storage_service.dart';

class BalunNavigationBarBadgeService extends ValueNotifier<int?> {
  final LoggerService logger;

  BalunNavigationBarBadgeService({
    required this.logger,
  }) : super(null);

  ///
  /// METHODS
  ///

  void updateBadge({
    required List<FixtureResponse> fixtures,
  }) {
    final favoriteFixtures = getFavoriteFixtures(
      fixtures: fixtures,
      favoritedLeagues: getIt
          .get<LeagueStorageService>()
          .value
          .map(
            (league) => League(
              id: league.id,
              name: league.name,
              logo: league.logo,
            ),
          )
          .toList(),
      favoritedTeams: getIt.get<TeamStorageService>().value,
    );

    value = favoriteFixtures.isNotEmpty ? favoriteFixtures.length : null;
  }
}
