import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

    final activeDateFormatted = DateFormat('d. MMMM').format(activeDate);

    return AlertDialog(
      elevation: 0,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///
          /// TITLE
          ///
          Text(
            'All matches',
            style: context.textStyles.dialogTitle,
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
                    TextSpan(children: [
                      TextSpan(
                        text: 'Section which shows all matches played on ',
                        style: context.textStyles.dialogText,
                      ),
                      TextSpan(
                        text: activeDateFormatted,
                        style: context.textStyles.dialogText.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: '.',
                        style: context.textStyles.dialogText,
                      ),
                    ]),
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
            'Okay'.toUpperCase(),
            style: context.textStyles.dialogButton,
          ),
        ),
      ],
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
      actionsPadding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      backgroundColor: context.colors.greenish,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: context.colors.black,
          width: 2,
        ),
      ),
    );
  }
}
