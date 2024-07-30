import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watch_it/watch_it.dart';

import 'screens/match/match_screen.dart';
import 'services/api_service.dart';
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
          matchId: 1034844,
        ),
        onGenerateTitle: (_) => 'Balun',
        theme: BalunTheme.light,
        builder: (_, child) => BalunWidget(
          child: child,
        ),
      );
}

class BalunWidget extends WatchingWidget {
  final Widget? child;

  const BalunWidget({
    required this.child,
  });

  @override
  Widget build(BuildContext context) => kDebugMode
      ? Banner(
          message: 'Debug'.toUpperCase(),
          color: context.colors.red,
          location: BannerLocation.topEnd,
          layoutDirection: TextDirection.ltr,
          child: Stack(
            children: [
              child ?? const BalunLoader(),
              Positioned(
                right: 12,
                top: MediaQuery.paddingOf(context).top + 16,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: context.colors.white,
                    ),
                    child: Column(
                      children: [
                        Text(
                          watchIt<APIService>().value.toString(),
                          style: TextStyle(
                            fontFamily: 'Lufga',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: context.colors.black,
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'API calls'.toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'Lufga',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: context.colors.black,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      : child ?? const BalunLoader();
}
