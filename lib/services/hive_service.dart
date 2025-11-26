import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../constants.dart';
import '../hive_registrar.g.dart';
import '../models/leagues/league/league.dart';
import '../models/notification/notification_fixture.dart';
import '../models/teams/team/team.dart';
import '../models/theme/theme_model.dart';
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

  late final Box<bool> firstStart;
  late final Box<bool> useNotifications;
  late final Box<ThemeModel> balunTheme;

  late final Box<League> leagues;
  late final Box<Team> teams;

  late final Box<NotificationFixture> notificationFixtures;

  ///
  /// INIT
  ///

  Future<void> init() async {
    final directory = await getHiveDirectory();

    Hive
      ..init(directory?.path)
      ..registerAdapters();

    firstStart = await Hive.openBox<bool>('firstStartBox');
    firstStart = await Hive.openBox<bool>('useNotificationsBox');
    balunTheme = await Hive.openBox<ThemeModel>('balunThemeBox');
    leagues = await Hive.openBox<League>('leaguesBox');
    teams = await Hive.openBox<Team>('teamsBox');
    notificationFixtures = await Hive.openBox<NotificationFixture>('notificationFixturesBox');

    if (firstStart.values.isEmpty) {
      await writeLeagues(BalunConstants.popularLeagues);
      await writeFirstStart();
    }
  }

  ///
  /// DISPOSE
  ///

  @override
  Future<void> onDispose() async {
    await firstStart.close();
    await useNotifications.close();
    await balunTheme.close();
    await leagues.close();
    await teams.close();
    await notificationFixtures.close();

    await Hive.close();
  }

  ///
  /// METHODS
  ///

  BalunThemeEnum? getBalunTheme() => balunTheme.values.toList().firstOrNull?.balunThemeEnum;

  bool getUseNotifications() => useNotifications.values.toList().firstOrNull ?? false;

  Future<void> writeBalunTheme(BalunThemeEnum? newBalunThemeEnum) async {
    await balunTheme.clear();

    if (newBalunThemeEnum != null) {
      await balunTheme.put(
        0,
        ThemeModel(balunThemeEnum: newBalunThemeEnum),
      );
    }
  }

  Future<void> writeFirstStart() async {
    await firstStart.clear();
    await firstStart.put(0, false);
  }

  Future<void> writeUseNotifications(bool value) async {
    await useNotifications.clear();
    await useNotifications.put(0, value);
  }

  Future<void> writeLeagues(List<League> passedLeagues) async {
    await leagues.clear();
    await leagues.addAll(passedLeagues);
  }

  Future<void> writeTeams(List<Team> passedTeams) async {
    await teams.clear();
    await teams.addAll(passedTeams);
  }
}
