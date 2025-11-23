// ignore_for_file: implementation_imports

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/easy_localization_controller.dart';
import 'package:easy_localization/src/localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../generated/codegen_loader.g.dart';

/// Initialize [EasyLocalization]
Future<void> initializeLocalization() async {
  await EasyLocalization.ensureInitialized();

  final controller = EasyLocalizationController(
    useOnlyLangCode: true,
    supportedLocales: const [Locale('hr'), Locale('en')],
    path: 'assets/translations',
    fallbackLocale: const Locale('hr'),
    saveLocale: true,
    useFallbackTranslations: true,
    assetLoader: const CodegenLoader(),
    onLoadError: (e) {},
  );

  await controller.loadTranslations();

  Localization.load(
    controller.locale,
    translations: controller.translations,
    fallbackTranslations: controller.fallbackTranslations,
  );

  await initializeDateFormatting('en');
  await initializeDateFormatting('hr');
}
