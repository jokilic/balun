import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:package_info_plus/package_info_plus.dart';
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

  /// Initialize [EasyLocalization]
  await EasyLocalization.ensureInitialized();

  /// Initialize services
  initializeServices();

  /// Initialize date formatting and `timeago` messages
  await initializeDateFormatting();
  timeago.setLocaleMessages('en', timeago.EnMessages());
  timeago.setLocaleMessages('hr', timeago.HrMessages());

  /// Wait for initialization to finish
  await getIt.allReady();

  /// Get app version
  final packageInfo = await PackageInfo.fromPlatform();

  /// Run [Balun]
  runApp(
    BalunApp(
      appVersion: packageInfo.version,
    ),
  );
}

class BalunApp extends StatefulWidget {
  final String appVersion;

  const BalunApp({
    required this.appVersion,
  });

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
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('hr'),
        path: 'assets/translations',
        child: BalunWidget(
          appVersion: widget.appVersion,
        ),
      );
}

class BalunWidget extends WatchingWidget {
  final String appVersion;

  const BalunWidget({
    required this.appVersion,
  });

  @override
  Widget build(BuildContext context) => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        home: watchIt<BalunScreenService>().value,
        onGenerateTitle: (_) => 'appName'.tr(),
        theme: BalunTheme.light,
        builder: (_, child) => Banner(
          message: appVersion.toUpperCase(),
          color: getRandomBalunColor(context),
          location: BannerLocation.topEnd,
          layoutDirection: TextDirection.ltr,
          child: child ??
              const Scaffold(
                body: Center(
                  child: BalunLoader(),
                ),
              ),
        ),
      );
}
