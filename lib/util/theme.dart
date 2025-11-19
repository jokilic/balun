import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/theme/theme_model.dart';
import '../theme/theme.dart';

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
