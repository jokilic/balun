import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:watch_it/watch_it.dart';

import 'services/balun_screen_service.dart';
import 'theme/theme.dart';
import 'util/color.dart';
import 'util/dependencies.dart';
import 'util/env.dart';
import 'widgets/balun_loader.dart';

Future<void> main() async {
  /// Initialize Flutter related tasks
  WidgetsFlutterBinding.ensureInitialized();

  /// Make sure the orientation is only `portrait`
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  /// Initialize [EasyLocalization]
  await EasyLocalization.ensureInitialized();

  /// Initialize services
  initializeServices(
    enableRemoteSettings: !kDebugMode && defaultTargetPlatform == TargetPlatform.iOS,
    enablePeriodicFetching: !kDebugMode,
  );

  /// Initialize date formatting and `timeago` messages
  await initializeDateFormatting();
  timeago.setLocaleMessages('en', timeago.EnMessages());
  timeago.setLocaleMessages('hr', timeago.HrMessages());

  /// Wait for initialization to finish
  await getIt.allReady();

  /// Initialize [Sentry] & run [Balun]
  await SentryFlutter.init(
    (options) => options
      ..dsn = kDebugMode ? '' : Env.sentryDsn
      ..debug = kDebugMode,
    appRunner: () => runApp(
      BalunApp(),
    ),
  );
}

class BalunApp extends StatefulWidget {
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
  Widget build(BuildContext context) => EasyLocalization(
        useOnlyLangCode: true,
        supportedLocales: const [
          Locale('en'),
          Locale('hr'),
        ],
        // startLocale: const Locale('hr'),
        fallbackLocale: const Locale('hr'),
        path: 'assets/translations',
        child: BalunWidget(),
      );
}

class BalunWidget extends WatchingWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        home: watchIt<BalunScreenService>().value,
        onGenerateTitle: (_) => 'appName'.tr(),
        theme: BalunTheme.light,
        builder: (_, child) => kDebugMode
            ? Banner(
                message: 'appName'.tr().toUpperCase(),
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
