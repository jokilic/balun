import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../theme/theme.dart';
import '../../../widgets/balun_button.dart';
import '../controllers/fixtures_date_controller.dart';

class FixturesAllDialog extends WatchingWidget {
  final Function() onPressed;

  const FixturesAllDialog({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final activeDate = watchIt<FixturesDateController>(
      instanceName: 'fixtures',
    ).value;

    final activeDateFormatted = DateFormat(
      'd. MMMM',
      context.locale.toLanguageTag(),
    ).format(activeDate);

    return AlertDialog(
      elevation: 0,
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
      actionsPadding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      backgroundColor: context.colors.accentLight,
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
            'fixturesAllTitle'.tr(),
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
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'fixturesAllDialogText'.tr(),
                          style: context.textStyles.bodyMdLight,
                        ),
                        TextSpan(
                          text: activeDateFormatted,
                          style: context.textStyles.bodyMdLight.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: '.',
                          style: context.textStyles.bodyMdLight,
                        ),
                      ],
                    ),
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
}
