import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/theme/theme_model.dart';
import '../../../theme/theme.dart';
import 'theme_value.dart';

class ThemeContent extends StatelessWidget {
  final BalunThemeEnum? themeState;
  final Function(BalunThemeEnum? themeState) onPressedTheme;

  const ThemeContent({
    required this.themeState,
    required this.onPressedTheme,
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
          'themeText1'.tr(),
          style: context.textStyles.bodyMdLight,
        ),
      ),
      const SizedBox(height: 12),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'themeText2'.tr(),
          style: context.textStyles.bodyMdLight,
        ),
      ),
      const SizedBox(height: 12),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'themeText3'.tr(),
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
          'themesThemesTitle'.tr(),
          style: context.textStyles.titleMd,
        ),
      ),
      const SizedBox(height: 12),

      ///
      /// THEMES
      ///
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 32,
          runSpacing: 32,
          children: [
            ///
            /// SYSTEM
            ///
            ThemeValue(
              onPressedTheme: onPressedTheme,
              themeEnum: null,
              activeTheme: themeState,
            ),

            ///
            /// OTHER THEMES
            ///
            ...BalunThemeEnum.values
                .map(
                  (themeEnum) => ThemeValue(
                    onPressedTheme: onPressedTheme,
                    themeEnum: themeEnum,
                    activeTheme: themeState,
                  ),
                )
                .toList(),
          ],
        ),
      ),
    ],
  );
}
