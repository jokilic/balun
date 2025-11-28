import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/notification/notification_settings.dart';
import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../widgets/settings_list_tile.dart';

class NotificationsContent extends StatelessWidget {
  final NotificationSettings notificationsState;
  final Function() onPressedFavoriteLeagues;
  final Function() onPressedFavoriteTeams;
  final Function() onPressedTestNotification;
  final Function() onPressedTriggerNotification;

  const NotificationsContent({
    required this.notificationsState,
    required this.onPressedFavoriteLeagues,
    required this.onPressedFavoriteTeams,
    required this.onPressedTestNotification,
    required this.onPressedTriggerNotification,
  });

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.only(top: 8, bottom: 24),
    physics: const BouncingScrollPhysics(),
    children: [
      ///
      /// TEXT
      ///
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'notificationsText1'.tr(),
          style: context.textStyles.bodyMdLight,
        ),
      ),
      const SizedBox(height: 12),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'notificationsText2'.tr(),
          style: context.textStyles.bodyMdLight,
        ),
      ),
      const SizedBox(height: 20),

      ///
      /// FAVORITE LEAGUES
      ///
      SettingsListTile(
        onPressed: onPressedFavoriteLeagues,
        icon: BalunIcons.notificationLeague,
        title: 'notificationsFavoriteLeaguesTitle'.tr(),
        subtitle: 'notificationsFavoriteLeaguesSubtitle'.tr(),
        isActive: notificationsState.showLeagueNotifications,
      ),

      ///
      /// FAVORITE TEAMS
      ///
      SettingsListTile(
        onPressed: onPressedFavoriteTeams,
        icon: BalunIcons.notificationTeam,
        title: 'notificationsFavoriteTeamsTitle'.tr(),
        subtitle: 'notificationsFavoriteTeamsSubtitle'.tr(),
        isActive: notificationsState.showTeamNotifications,
      ),

      ///
      /// TEST NOTIFICATION
      ///
      SettingsListTile(
        onPressed: onPressedTestNotification,
        icon: BalunIcons.notifications,
        title: 'notificationsTestNotificationTitle'.tr(),
        subtitle: 'notificationsTestNotificationSubtitle'.tr(),
      ),

      ///
      /// TRIGGER NOTIFICATIONS
      ///
      SettingsListTile(
        onPressed: onPressedTriggerNotification,
        icon: BalunIcons.notifications,
        title: 'Trigger notifications',
        subtitle: 'Do the notification logic',
      ),
    ],
  );
}
