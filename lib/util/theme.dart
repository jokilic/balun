import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/theme/theme_model.dart';
import '../theme/colors.dart';
import '../theme/theme.dart';

String? getThemeSnackbarText(BalunThemeEnum? themeEnum) => switch (themeEnum) {
  BalunThemeEnum.light => 'snackbarSettingsThemeLight'.tr(),
  BalunThemeEnum.dark => 'snackbarSettingsThemeDark'.tr(),
  _ => 'snackbarSettingsThemeSystem'.tr(),
};

String getThemeName(BalunThemeEnum? themeEnum) => switch (themeEnum) {
  BalunThemeEnum.light => 'settingsThemeLight'.tr(),
  BalunThemeEnum.dark => 'settingsThemeDark'.tr(),
  _ => 'settingsThemeSystem'.tr(),
};

ThemeData? getBalunTheme(BalunThemeEnum? themeEnum) => switch (themeEnum) {
  BalunThemeEnum.light => BalunTheme.light,
  BalunThemeEnum.dark => BalunTheme.dark,
  _ => null,
};

Color? getThemeColor(BalunThemeEnum? themeEnum) => switch (themeEnum) {
  BalunThemeEnum.light => BalunColors.light,
  BalunThemeEnum.dark => BalunColors.dark,
  _ => null,
};
