import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watch_it/watch_it.dart';

import 'services/balun_screen_service.dart';
import 'services/dio_service.dart';
import 'theme/theme.dart';
import 'util/dependencies.dart';
import 'widgets/balun_loader.dart';
import 'widgets/balun_remaining_requests.dart';

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

class BalunApp extends WatchingWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      home: watchIt<BalunScreenService>().value,
      onGenerateTitle: (_) => 'Balun',
      theme: BalunTheme.light,
      builder: (_, child) => BalunWidget(child: child));
}

class BalunWidget extends WatchingWidget {
  final Widget? child;

  const BalunWidget({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final remainingRequests = watchIt<DioService>().value;

    return kDebugMode
        ? Banner(
            message: 'Debug'.toUpperCase(),
            color: context.colors.blue,
            location: BannerLocation.topEnd,
            layoutDirection: TextDirection.ltr,
            child: Stack(
              children: [
                child ??
                    const Scaffold(
                      body: Center(
                        child: BalunLoader(),
                      ),
                    ),
                if (remainingRequests != null)
                  Positioned(
                    bottom: MediaQuery.paddingOf(context).bottom,
                    right: 16,
                    child: BalunRemainingRequests(
                      remainingRequests: remainingRequests,
                    ),
                  ),
              ],
            ),
          )
        : Stack(
            children: [
              child ??
                  const Scaffold(
                    body: Center(
                      child: BalunLoader(),
                    ),
                  ),
              if (remainingRequests != null)
                Positioned(
                  bottom: MediaQuery.paddingOf(context).bottom,
                  right: 16,
                  child: BalunRemainingRequests(
                    remainingRequests: remainingRequests,
                  ),
                ),
            ],
          );
  }
}
