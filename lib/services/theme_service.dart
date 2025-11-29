import 'package:flutter/material.dart';

import '../models/theme/theme_model.dart';
import 'hive_service.dart';
import 'logger_service.dart';

class ThemeService extends ValueNotifier<BalunThemeEnum?> {
  final LoggerService logger;
  final HiveService hive;

  ThemeService({
    required this.logger,
    required this.hive,
  }) : super(hive.getBalunTheme());

  ///
  /// METHODS
  ///

  Future<void> setTheme({required BalunThemeEnum? newThemeEnum}) async {
    value = newThemeEnum;
    await hive.writeBalunTheme(newThemeEnum);
  }
}
