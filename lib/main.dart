import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/match/match_screen.dart';
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

  /// Initialize lazy controllers
  initializeControllers();

  /// Wait for initialization to finish
  await getIt.allReady();

  /// Run [Balun]
  runApp(BalunApp());
}

class BalunApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MatchScreen(
          matchId: 1034682,
        ),
        onGenerateTitle: (_) => 'Balun',
        theme: BalunTheme.light,
        builder: (context, child) => kDebugMode
            ? Banner(
                message: 'Debug'.toUpperCase(),
                color: context.colors.red,
                location: BannerLocation.topEnd,
                layoutDirection: TextDirection.ltr,
                child: child ?? BalunLoader(),
              )
            : child ?? BalunLoader(),
      );
}
