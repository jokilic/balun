import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../routing.dart';
import '../../../theme/icons.dart';
import '../../../util/language.dart';
import '../../../util/snackbars.dart';
import 'settings_list_tile.dart';

class SettingsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.only(bottom: 24),
        physics: const BouncingScrollPhysics(),
        children: [
          SettingsListTile(
            onPressed: () => showSnackbar(
              context,
              icon: BalunIcons.workInProgress,
              text: 'workInProgress'.tr(),
            ),
            icon: BalunIcons.notifications,
            title: 'settingsNotificationsSectionTitle'.tr(),
            subtitle: 'settingsNotificationsSectionSubtitle'.tr(),
          ),
          const SizedBox(height: 4),
          SettingsListTile(
            onPressed: () => openFavorites(context),
            icon: BalunIcons.favoriteYes,
            title: 'settingsFavoritesSectionTitle'.tr(),
            subtitle: 'settingsFavoritesSectionSubtitle'.tr(),
          ),
          const SizedBox(height: 4),
          SettingsListTile(
            onPressed: () => showSnackbar(
              context,
              icon: BalunIcons.workInProgress,
              text: 'workInProgress'.tr(),
            ),
            icon: BalunIcons.theme,
            title: 'settingsThemeSectionTitle'.tr(),
            subtitle: 'settingsThemeSectionSubtitle'.tr(),
          ),
          const SizedBox(height: 4),
          SettingsListTile(
            onPressed: () => toggleLanguage(context),
            icon: BalunIcons.language,
            title: 'settingsLanguageSectionTitle'.tr(),
            subtitle: 'settingsLanguageSectionSubtitle'.tr(),
          ),
          const SizedBox(height: 4),
          SettingsListTile(
            onPressed: () => openAbout(context),
            icon: BalunIcons.about,
            title: 'settingsAboutSectionTitle'.tr(),
            subtitle: 'settingsAboutSectionSubtitle'.tr(),
          ),
        ],
      );
}
