import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../constants.dart';
import '../models/leagues/league/league.dart';
import '../models/teams/team/team.dart';
import '../util/path.dart';
import 'logger_service.dart';

class HiveService implements Disposable {
  final LoggerService logger;

  HiveService({
    required this.logger,
  });

  ///
  /// VARIABLES
  ///

  late final Box<League> leagues;
  late final Box<Team> teams;

  ///
  /// INIT
  ///

  Future<void> init() async {
    final directory = await getHiveDirectory();

    Hive
      ..init(directory?.path)
      ..registerAdapter(LeagueAdapter())
      ..registerAdapter(TeamAdapter());

    leagues = await Hive.openBox<League>('leagueBox');
    teams = await Hive.openBox<Team>('teamBox');

    if (leagues.isEmpty) {
      await writeLeagues(BalunConstants.popularLeagues);
    }
  }

  ///
  /// DISPOSE
  ///

  @override
  Future<void> onDispose() async {
    await leagues.close();
    await teams.close();
    await Hive.close();
  }

  ///
  /// METHODS
  ///

  Future<void> writeLeagues(List<League> passedLeagues) async {
    await leagues.clear();
    await leagues.addAll(passedLeagues);
  }

  Future<void> writeTeams(List<Team> passedTeams) async {
    await teams.clear();
    await teams.addAll(passedTeams);
  }
}
