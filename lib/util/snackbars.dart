import 'package:flutter/material.dart';

import '../theme/theme.dart';

void showSnackbar(BuildContext context, {required String text}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: context.textStyles.fixturesName.copyWith(
          color: context.colors.red,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: context.colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: context.colors.red,
          width: 2,
        ),
      ),
    ),
  );
}
