import 'package:flutter/material.dart';

import '../../../models/theme/theme_model.dart';
import '../../../theme/colors.dart';
import '../../../theme/theme.dart';
import '../../../util/theme.dart';
import '../../../widgets/balun_button.dart';

class ThemeValue extends StatelessWidget {
  final Function(BalunThemeEnum? themeState) onPressedTheme;
  final BalunThemeEnum? themeEnum;
  final BalunThemeEnum? activeTheme;

  const ThemeValue({
    required this.onPressedTheme,
    required this.themeEnum,
    required this.activeTheme,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      ///
      /// ICON
      ///
      BalunButton(
        onPressed: () => onPressedTheme(themeEnum),
        child: Container(
          padding: const EdgeInsets.all(8),

          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: themeEnum == activeTheme ? context.colors.primaryBackgroundLight : context.colors.accent,
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: getThemeColor(themeEnum),
              gradient: themeEnum == null
                  ? const LinearGradient(
                      colors: [
                        BalunColors.light,
                        BalunColors.light,
                        BalunColors.dark,
                        BalunColors.dark,
                      ],
                      stops: [0.0, 0.5, 0.5, 1.0],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
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
        getThemeName(themeEnum),
        style: themeEnum == activeTheme ? context.textStyles.bodyMdExtraBold : context.textStyles.bodyMd,
      ),
    ],
  );
}
