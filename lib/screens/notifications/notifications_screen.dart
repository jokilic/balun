import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants.dart';
import '../../services/background_fetch_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../services/notification_service.dart';
import '../../util/dependencies.dart';
import 'notifications_controller.dart';
import 'widgets/notifications_app_bar.dart';
import 'widgets/notifications_content.dart';

class NotificationsScreen extends WatchingStatefulWidget {
  const NotificationsScreen({
    required super.key,
  });

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();

    registerIfNotInitialized<NotificationsController>(
      () => NotificationsController(
        logger: getIt.get<LoggerService>(),
        hive: getIt.get<HiveService>(),
        notification: getIt.get<NotificationService>(),
        backgroundFetch: getIt.get<BackgroundFetchService>(),
      ),
      instanceName: 'notifications',
    );
  }

  @override
  Widget build(BuildContext context) {
    final notificationsState = watchIt<NotificationsController>(
      instanceName: 'notifications',
    ).value;

    return Scaffold(
      body: SafeArea(
        child: Animate(
          effects: const [
            FadeEffect(
              curve: Curves.easeIn,
              duration: BalunConstants.longAnimationDuration,
            ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              ///
              /// APP BAR
              ///
              NotificationsAppBar(
                onPressed: Navigator.of(context).pop,
              ),
              const SizedBox(height: 8),

              ///
              /// CONTENT
              ///
              Expanded(
                child: Animate(
                  effects: const [
                    FadeEffect(
                      curve: Curves.easeIn,
                      duration: BalunConstants.animationDuration,
                    ),
                  ],
                  child: NotificationsContent(
                    notificationsState: notificationsState,
                    onPressedFavoriteLeagues: getIt.get<NotificationsController>(instanceName: 'notifications').onPressedFavoriteLeagues,
                    onPressedFavoriteTeams: getIt.get<NotificationsController>(instanceName: 'notifications').onPressedFavoriteTeams,
                    onPressedFavoriteMatches: getIt.get<NotificationsController>(instanceName: 'notifications').onPressedFavoriteMatches,
                    onPressedNotificationSound: getIt.get<NotificationsController>(instanceName: 'notifications').onPressedNotificationSound,
                    onPressedTestNotification: getIt.get<NotificationsController>(instanceName: 'notifications').testNotification,
                    onPressedTriggerNotifications: getIt.get<NotificationsController>(instanceName: 'notifications').triggerNotifications,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
