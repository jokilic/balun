// ignore_for_file: use_setters_to_change_properties

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../services/logger_service.dart';

class LanguageController extends ValueNotifier<Locale?> {
  final LoggerService logger;

  LanguageController({
    required this.logger,
  }) : super(null);

  ///
  /// INIT
  ///

  void init({required Locale locale}) {
    value = locale;
  }

  ///
  /// METHODS
  ///

  Future<void> onPressedLanguage({
    required BuildContext context,
    required String languageCode,
  }) async {
    final newLocale = Locale(languageCode);
    value = newLocale;
    await context.setLocale(newLocale);
  }
}
