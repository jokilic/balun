import 'package:flutter/material.dart';

import '../../../routing.dart';
import '../../../theme/icons.dart';
import 'settings_list_tile.dart';

// TODO: Localize
class SettingsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.only(bottom: 24),
        physics: const BouncingScrollPhysics(),
        children: [
          SettingsListTile(
            onPressed: () {},
            icon: BalunIcons.notifications,
            title: 'Notifications',
            subtitle: 'Live score alerts, goal updates & match start reminders',
          ),
          const SizedBox(height: 4),
          SettingsListTile(
            onPressed: () => openFavorites(context),
            icon: BalunIcons.favoriteYes,
            title: 'Favorites',
            subtitle: 'Select your favorite teams & leagues for a personalized feed',
          ),
          const SizedBox(height: 4),
          SettingsListTile(
            onPressed: () {},
            icon: BalunIcons.theme,
            title: 'Theme',
            subtitle: 'Customize colors used throughout the app',
          ),
          const SizedBox(height: 4),
          SettingsListTile(
            onPressed: () {},
            icon: BalunIcons.language,
            title: 'Language',
            subtitle: 'Change the language used throughout the app',
          ),
          const SizedBox(height: 4),
          SettingsListTile(
            onPressed: () {},
            icon: BalunIcons.about,
            title: 'About',
            subtitle: 'App version info, developer details & send feedback',
          ),
        ],
      );
}
