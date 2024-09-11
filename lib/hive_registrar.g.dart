import 'package:hive_ce/hive.dart';
import 'package:balun/models/leagues/league/league.dart';
import 'package:balun/models/teams/team/team.dart';

extension HiveRegistrar on HiveInterface {
  void registerAdapters() {
    registerAdapter(LeagueAdapter());
    registerAdapter(TeamAdapter());
  }
}
