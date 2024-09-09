import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:watch_it/watch_it.dart';

import 'services/balun_screen_service.dart';
import 'theme/theme.dart';
import 'util/color.dart';
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

  /// Initialize date formatting and `timeago` messages
  await initializeDateFormatting();
  timeago.setLocaleMessages('en', timeago.EnMessages());
  timeago.setLocaleMessages('hr', timeago.HrMessages());

  /// Wait for initialization to finish
  await getIt.allReady();

  /// Run [Balun]
  runApp(BalunApp());
}

class BalunApp extends WatchingStatefulWidget {
  @override
  State<BalunApp> createState() => _BalunAppState();
}

class _BalunAppState extends State<BalunApp> {
  @override
  void initState() {
    /// Set the color of the navigation bar
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: context.colors.black,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        supportedLocales: const [
          Locale('en'),
          Locale('hr'),
        ],
        debugShowCheckedModeBanner: false,
        home: watchIt<BalunScreenService>().value,
        onGenerateTitle: (_) => 'Balun',
        theme: BalunTheme.light,
        builder: (_, child) => kDebugMode
            ? Banner(
                message: 'Balun'.toUpperCase(),
                color: getRandomBalunColor(context),
                location: BannerLocation.topEnd,
                layoutDirection: TextDirection.ltr,
                child: child ??
                    const Scaffold(
                      body: Center(
                        child: BalunLoader(),
                      ),
                    ),
              )
            : child ??
                const Scaffold(
                  body: Center(
                    child: BalunLoader(),
                  ),
                ),
      );
}
