import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../widgets/balun_button.dart';

class FixturesFavoriteDialog extends StatelessWidget {
  final Function() onPressed;

  const FixturesFavoriteDialog({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => AlertDialog(
    elevation: 0,
    contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
    actionsPadding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
    backgroundColor: context.colors.accent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(
        color: context.colors.primaryForeground,
        width: 2,
      ),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///
        /// TITLE
        ///
        Text(
          'fixturesFavoriteTitle'.tr(),
          style: context.textStyles.headlineLg,
        ),
        const SizedBox(height: 8),
        Flexible(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///
                /// TEXT
                ///
                Text(
                  'fixturesFavoriteDialogText1'.tr(),
                  style: context.textStyles.bodyMdLight,
                ),
                const SizedBox(height: 12),
                Text(
                  'fixturesFavoriteDialogText2'.tr(),
                  style: context.textStyles.bodyMdLight,
                ),
                const SizedBox(height: 16),
                Text(
                  'fixturesFavoriteDialogText3'.tr(),
                  style: context.textStyles.bodyMdLight,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    actions: [
      BalunButton(
        onPressed: onPressed,
        child: Text(
          'fixturesDialogOkay'.tr().toUpperCase(),
          style: context.textStyles.bodyMdExtraBold,
        ),
      ),
    ],
  );
}
