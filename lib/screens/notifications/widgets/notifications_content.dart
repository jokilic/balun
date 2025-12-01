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
  final Function() onPressedFavoriteMatches;
  final Function() onPressedTriggerMatchStart;
  final Function() onPressedTriggerGoal;
  final Function() onPressedTriggerMatchProgress;
  final Function() onPressedTriggerFullTime;
  final Function() onPressedNotificationSound;
  final Function() onPressedTestNotification;
  final Function() onPressedTriggerNotifications;

  const NotificationsContent({
    required this.notificationsState,
    required this.onPressedFavoriteLeagues,
    required this.onPressedFavoriteTeams,
    required this.onPressedFavoriteMatches,
    required this.onPressedTriggerMatchStart,
    required this.onPressedTriggerGoal,
    required this.onPressedTriggerMatchProgress,
    required this.onPressedTriggerFullTime,
    required this.onPressedNotificationSound,
    required this.onPressedTestNotification,
    required this.onPressedTriggerNotifications,
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
      const SizedBox(height: 12),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'notificationsText3'.tr(),
          style: context.textStyles.bodyMdLight,
        ),
      ),
      const SizedBox(height: 24),

      ///
      /// TITLE
      ///
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'notificationsNotificationsTitle'.tr(),
          style: context.textStyles.titleMd,
        ),
      ),
      const SizedBox(height: 2),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'notificationsNotificationsSubtitle'.tr(),
          style: context.textStyles.bodyMdLight,
        ),
      ),
      const SizedBox(height: 12),

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
      /// FAVORITE MATCHES
      ///
      SettingsListTile(
        onPressed: onPressedFavoriteMatches,
        icon: BalunIcons.notificationMatch,
        title: 'notificationsFavoriteMatchesTitle'.tr(),
        subtitle: 'notificationsFavoriteMatchesSubtitle'.tr(),
        isActive: notificationsState.showMatchNotifications,
      ),
      const SizedBox(height: 24),

      ///
      /// TITLE
      ///
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'notificationsTriggersTitle'.tr(),
          style: context.textStyles.titleMd,
        ),
      ),
      const SizedBox(height: 2),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'notificationsTriggersSubtitle'.tr(),
          style: context.textStyles.bodyMdLight,
        ),
      ),
      const SizedBox(height: 12),

      ///
      /// MATCH START
      ///
      SettingsListTile(
        onPressed: onPressedTriggerMatchStart,
        icon: BalunIcons.notificationMatchStart,
        title: 'notificationMatchStartTitle'.tr(),
        subtitle: 'notificationMatchStartSubtitle'.tr(),
        isActive: notificationsState.triggerMatchStart,
      ),

      ///
      /// GOAL
      ///
      SettingsListTile(
        onPressed: onPressedTriggerGoal,
        icon: BalunIcons.notificationGoal,
        title: 'notificationGoalTitle'.tr(),
        subtitle: 'notificationGoalSubtitle'.tr(),
        isActive: notificationsState.triggerGoal,
      ),

      ///
      /// MATCH PROGRESS
      ///
      SettingsListTile(
        onPressed: onPressedTriggerMatchProgress,
        icon: BalunIcons.notificationMatchProgress,
        title: 'notificationMatchProgressTitle'.tr(),
        subtitle: 'notificationMatchProgressSubtitle'.tr(),
        isActive: notificationsState.triggerMatchProgress,
      ),

      ///
      /// FULL TIME
      ///
      SettingsListTile(
        onPressed: onPressedTriggerFullTime,
        icon: BalunIcons.notificationFullTime,
        title: 'notificationFullTimeTitle'.tr(),
        subtitle: 'notificationFullTimeSubtitle'.tr(),
        isActive: notificationsState.triggerFullTime,
      ),
      const SizedBox(height: 24),

      ///
      /// TITLE
      ///
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'notificationsSoundsTitle'.tr(),
          style: context.textStyles.titleMd,
        ),
      ),
      const SizedBox(height: 2),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'notificationsSoundsSubtitle'.tr(),
          style: context.textStyles.bodyMdLight,
        ),
      ),
      const SizedBox(height: 12),

      ///
      /// NOTIFICATION SOUND
      ///
      SettingsListTile(
        onPressed: onPressedNotificationSound,
        icon: BalunIcons.notificationSound,
        title: 'notificationSoundTitle'.tr(),
        subtitle: 'notificationSoundSubtitle'.tr(),
        isActive: notificationsState.playNotificationSound,
      ),
      const SizedBox(height: 24),

      ///
      /// TITLE
      ///
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'notificationsTestingTitle'.tr(),
          style: context.textStyles.titleMd,
        ),
      ),
      const SizedBox(height: 2),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'notificationsTestingSubtitle'.tr(),
          style: context.textStyles.bodyMdLight,
        ),
      ),
      const SizedBox(height: 12),

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
        onPressed: onPressedTriggerNotifications,
        icon: BalunIcons.notificationCheckbox,
        title: 'notificationsTriggerNotificationsTitle'.tr(),
        subtitle: 'notificationsTriggerNotificationsSubtitle'.tr(),
      ),
    ],
  );
}
