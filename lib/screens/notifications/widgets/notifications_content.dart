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

  const NotificationsContent({
    required this.notificationsState,
    required this.onPressedFavoriteLeagues,
    required this.onPressedFavoriteTeams,
    required this.onPressedTestNotification,
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
          // TODO: Localize
          'Here you can toggle notifications which get sent to your device as fixtures progress.',
          style: context.textStyles.bodyMdLight,
        ),
      ),
      const SizedBox(height: 12),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          // TODO: Localize
          'Keep in mind Balun is not using any backend infrastructure and notifications are reliant on the OS allowing the app to wake-up and check for fixture updates.',
          style: context.textStyles.bodyMdLight,
        ),
      ),
      const SizedBox(height: 20),

      ///
      /// FAVORITE LEAGUES
      ///
      SettingsListTile(
        onPressed: onPressedFavoriteLeagues,
        icon: BalunIcons.placeholderLeague,
        // TODO: Localize
        title: 'Favorite leagues',
        subtitle: 'Notifications for your favorite leagues',
      ),

      ///
      /// FAVORITE TEAMS
      ///
      SettingsListTile(
        onPressed: onPressedFavoriteTeams,
        icon: BalunIcons.placeholderTeam,
        // TODO: Localize
        title: 'Favorite teams',
        subtitle: 'Notifications for your favorite teams',
      ),

      ///
      /// TEST NOTIFICATION
      ///
      SettingsListTile(
        onPressed: onPressedTestNotification,
        icon: BalunIcons.notifications,
        // TODO: Localize
        title: 'Test notification',
        subtitle: 'Send a test notification',
      ),
    ],
  );
}
