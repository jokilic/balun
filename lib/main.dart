import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:watch_it/watch_it.dart';

import 'services/balun_screen_service.dart';
import 'theme/theme.dart';
import 'util/color.dart';
import 'util/dependencies.dart';
import 'util/display_mode.dart';
import 'widgets/balun_loader.dart';
import 'widgets/balun_navigation_bar.dart';

Future<void> main() async {
  /// Initialize Flutter related tasks
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// Make sure the orientation is only `portrait`
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  /// Use `edge-to-edge` display
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  /// Set refresh rate to high
  await setDisplayMode();

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

  /// Run [Balun]
  runApp(BalunApp());
}

class BalunApp extends StatefulWidget {
  @override
  State<BalunApp> createState() => _BalunAppState();
}

class _BalunAppState extends State<BalunApp> {
  @override
  void initState() {
    super.initState();

    /// Set the color of the navigation bar
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: context.colors.primaryForeground,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => EasyLocalization(
    useOnlyLangCode: true,
    supportedLocales: const [
      Locale('en'),
      Locale('hr'),
    ],
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
    home: Scaffold(
      bottomNavigationBar: BalunNavigationBar(),
      body: watchIt<BalunScreenService>().value,
    ),
    onGenerateTitle: (_) => 'appName'.tr(),
    theme: BalunTheme.light,
    builder: (_, child) {
      /// Generate `appWidget`, with [Balun] content
      final appWidget =
          child ??
          const Scaffold(
            body: Center(
              child: BalunLoader(),
            ),
          );

      /// Return `appWidget`, also [Banner] if app is `debug`
      return kDebugMode
          ? Banner(
              message: 'appName'.tr().toUpperCase(),
              color: getRandomBalunColor(context),
              location: BannerLocation.topEnd,
              layoutDirection: TextDirection.ltr,
              child: appWidget,
            )
          : appWidget;
    },
  );
}
