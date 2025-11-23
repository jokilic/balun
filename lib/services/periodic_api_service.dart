import 'dart:async';

import 'package:get_it/get_it.dart';

import '../constants.dart';
import '../screens/fixtures/controllers/fixtures_controller.dart';
import '../screens/fixtures/controllers/fixtures_date_controller.dart';
import '../screens/match/controllers/match_controller.dart';
import '../util/date_time.dart';
import '../util/dependencies.dart';
import 'logger_service.dart';

class PeriodicAPIService implements Disposable {
  final LoggerService logger;

  PeriodicAPIService({
    required this.logger,
  });

  @override
  FutureOr onDispose() {
    fixturesTimer.cancel();
    matchTimer.cancel();
  }

  ///
  /// VARIABLES
  ///

  late final Timer fixturesTimer;
  late final Timer matchTimer;

  var shouldFetchFixtures = false;

  var shouldFetchMatch = false;
  int? matchId;

  ///
  /// INIT
  ///

  void init() {
    fixturesTimer = Timer.periodic(
      BalunConstants.periodicAPICallDuration,
      (_) {
        /// 1. `shouldFetchFixtures` is `true`
        /// 2. [FixturesController] & [FixturesDateController] are initialized
        if (shouldFetchFixtures && getIt.isRegistered<FixturesController>(instanceName: 'fixtures') && getIt.isRegistered<FixturesDateController>(instanceName: 'fixtures')) {
          /// Fetch `fixtures` without `state` updates
          getIt
              .get<FixturesController>(
                instanceName: 'fixtures',
              )
              .getPeriodicFixturesFromDate(
                dateString: getDateForBackend(
                  getIt
                      .get<FixturesDateController>(
                        instanceName: 'fixtures',
                      )
                      .value,
                ),
              );
        }
      },
    );

    matchTimer = Timer.periodic(
      BalunConstants.periodicAPICallDuration,
      (_) {
        /// 1. `shouldFetchMatch` is `true`
        /// 2. `matchId` is not `null`
        /// 3. [MatchController] is initialized
        if (shouldFetchMatch && matchId != null && getIt.isRegistered<MatchController>(instanceName: '$matchId')) {
          getIt
              .get<MatchController>(
                instanceName: '$matchId',
              )
              .getPeriodicMatch(
                matchId: matchId!,
              );
        }
      },
    );
  }
}
