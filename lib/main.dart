import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/fixtures/fixtures_screen.dart';
import 'screens/team/team_screen.dart';
import 'theme/theme.dart';
import 'util/dependencies.dart';
import 'widgets/balun_loader.dart';

Future<void> main() async {
  /// Initialize Flutter related tasks
  WidgetsFlutterBinding.ensureInitialized();

  /// Make sure the orientation is only `portrait`
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  /// Initialize services
  initializeServices();

  /// Wait for initialization to finish
  await getIt.allReady();

  /// Run [Balun]
  runApp(BalunApp());
}

class BalunApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: const TeamScreen(
        //   teamId: 620,
        //   key: ValueKey(620),
        //   season: 2023,
        // ),
        // home: const LeagueScreen(
        //   leagueId: 210,
        //   key: ValueKey(210),
        //   season: 2021,
        // ),
        // home: const MatchScreen(
        //   matchId: 1034682,
        //   key: ValueKey(1034682),
        // ),
        home: const FixturesScreen(
          key: ValueKey('fixtures'),
        ),
        onGenerateTitle: (_) => 'Balun',
        theme: BalunTheme.light,
        builder: (_, child) => kDebugMode
            ? Banner(
                message: 'Debug'.toUpperCase(),
                color: context.colors.blue,
                location: BannerLocation.topEnd,
                layoutDirection: TextDirection.ltr,
                child: child ?? const BalunLoader(),
              )
            : child ?? const BalunLoader(),
      );
}
