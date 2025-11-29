import 'package:flutter/material.dart';

import '../../models/theme/theme_model.dart';
import '../../services/logger_service.dart';
import '../../services/theme_service.dart';

class ThemeController extends ValueNotifier<BalunThemeEnum?> {
  final LoggerService logger;
  final ThemeService theme;

  ThemeController({
    required this.logger,
    required this.theme,
  }) : super(theme.value);

  ///
  /// METHODS
  ///

  Future<void> onPressedTheme({
    required BalunThemeEnum? themeEnum,
  }) async {
    value = themeEnum;
    await theme.setTheme(newThemeEnum: themeEnum);
  }
}
