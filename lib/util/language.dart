import 'package:easy_localization/easy_localization.dart';

import '../theme/icons.dart';

String? getLanguageSnackbarText(String languageCode) => switch (languageCode) {
  'hr' => 'settingsLanguageCroatian'.tr(),
  'en' => 'settingsLanguageEnglish'.tr(),
  _ => null,
};

String? getLanguageText(String languageCode) => switch (languageCode) {
  'hr' => 'languageCroatian'.tr(),
  'en' => 'languageEnglish'.tr(),
  _ => null,
};

String getLanguageIcon(String languageCode) => switch (languageCode) {
  'hr' => BalunIcons.croatia,
  'en' => BalunIcons.unitedKingdom,
  _ => BalunIcons.placeholderLanguage,
};
