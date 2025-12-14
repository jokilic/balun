import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../routing.dart';
import '../../../theme/icons.dart';
import '../../../widgets/settings_list_tile.dart';

class SettingsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.only(bottom: 24),
    physics: const BouncingScrollPhysics(),
    children: [
      SettingsListTile(
        onPressed: () {
          HapticFeedback.lightImpact();
          openNotifications(context);
        },
        icon: BalunIcons.notifications,
        title: 'settingsNotificationsSectionTitle'.tr(),
        subtitle: 'settingsNotificationsSectionSubtitle'.tr(),
      ),
      const SizedBox(height: 4),
      SettingsListTile(
        onPressed: () {
          HapticFeedback.lightImpact();
          openFavorites(context);
        },
        icon: BalunIcons.favoriteYes,
        title: 'settingsFavoritesSectionTitle'.tr(),
        subtitle: 'settingsFavoritesSectionSubtitle'.tr(),
      ),
      const SizedBox(height: 4),
      SettingsListTile(
        onPressed: () {
          HapticFeedback.lightImpact();
          openTheme(context);
        },
        icon: BalunIcons.theme,
        title: 'settingsThemeSectionTitle'.tr(),
        subtitle: 'settingsThemeSectionSubtitle'.tr(),
      ),
      const SizedBox(height: 4),
      SettingsListTile(
        onPressed: () {
          HapticFeedback.lightImpact();
          openLanguage(context);
        },
        icon: BalunIcons.language,
        title: 'settingsLanguageSectionTitle'.tr(),
        subtitle: 'settingsLanguageSectionSubtitle'.tr(),
      ),
      const SizedBox(height: 4),
      SettingsListTile(
        onPressed: () {
          HapticFeedback.lightImpact();
          openStatus(context);
        },
        icon: BalunIcons.status,
        title: 'settingsStatusSectionTitle'.tr(),
        subtitle: 'settingsStatusSectionSubtitle'.tr(),
      ),
      const SizedBox(height: 4),
      SettingsListTile(
        onPressed: () {
          HapticFeedback.lightImpact();
          openAbout(context);
        },
        icon: BalunIcons.about,
        title: 'settingsAboutSectionTitle'.tr(),
        subtitle: 'settingsAboutSectionSubtitle'.tr(),
      ),
    ],
  );
}
