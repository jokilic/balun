import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../util/language.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image.dart';

class LanguageContent extends StatelessWidget {
  final Locale? languageState;
  final Function(String languageCode) onPressedLanguage;

  const LanguageContent({
    required this.languageState,
    required this.onPressedLanguage,
  });

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.only(top: 8, bottom: 24),
    physics: const BouncingScrollPhysics(),
    children: [
      ///
      /// TEXT
      ///
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'languageText1'.tr(),
          style: context.textStyles.bodyMdLight,
        ),
      ),
      const SizedBox(height: 12),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'languageText2'.tr(),
          style: context.textStyles.bodyMdLight,
        ),
      ),
      const SizedBox(height: 24),

      ///
      /// TITLE
      ///
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'languageLanguagesTitle'.tr(),
          style: context.textStyles.titleMd,
        ),
      ),
      const SizedBox(height: 12),

      ///
      /// LANGUAGES
      ///
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 32,
          runSpacing: 32,
          children: ['hr', 'en']
              .map(
                (languageCode) => Column(
                  children: [
                    ///
                    /// ICON
                    ///
                    BalunButton(
                      onPressed: () => onPressedLanguage(languageCode),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: languageState == Locale(languageCode) ? context.colors.primaryBackgroundLight : context.colors.accent,
                        ),
                        child: BalunImage(
                          imageUrl: getLanguageIcon(
                            languageCode: languageCode,
                          ),
                          height: 56,
                          width: 56,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    ///
                    /// TITLE
                    ///
                    Text(
                      getLanguageText(
                            languageCode: languageCode,
                          ) ??
                          '--',
                      style: languageState == Locale(languageCode) ? context.textStyles.bodyMdExtraBold : context.textStyles.bodyMd,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    ],
  );
}
