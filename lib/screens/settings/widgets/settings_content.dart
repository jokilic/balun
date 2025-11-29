import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../routing.dart';
import '../../../services/theme_service.dart';
import '../../../theme/icons.dart';
import '../../../util/dependencies.dart';
import '../../../util/snackbars.dart';
import '../../../util/theme.dart';
import '../../../widgets/settings_list_tile.dart';

class SettingsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.only(bottom: 24),
    physics: const BouncingScrollPhysics(),
    children: [
      SettingsListTile(
        onPressed: () => openNotifications(context),
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
        onPressed: () async {
          final newTheme = await getIt.get<ThemeService>().toggleTheme();

          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          await Future.delayed(
            BalunConstants.longAnimationDuration,
          );

          final themeName = getThemeName(newTheme);

          showSnackbar(
            context,
            icon: BalunIcons.theme,
            text: themeName,
          );
        },
        icon: BalunIcons.theme,
        title: 'settingsThemeSectionTitle'.tr(),
        subtitle: 'settingsThemeSectionSubtitle'.tr(),
      ),
      const SizedBox(height: 4),
      SettingsListTile(
        onPressed: () => openLanguage(context),
        icon: BalunIcons.language,
        title: 'settingsLanguageSectionTitle'.tr(),
        subtitle: 'settingsLanguageSectionSubtitle'.tr(),
      ),
      const SizedBox(height: 4),
      SettingsListTile(
        onPressed: () => openStatus(context),
        icon: BalunIcons.status,
        title: 'settingsStatusSectionTitle'.tr(),
        subtitle: 'settingsStatusSectionSubtitle'.tr(),
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
