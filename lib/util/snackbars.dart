import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../widgets/balun_image/balun_image.dart';

void showSnackbar(
  BuildContext context, {
  required String text,
  required String icon,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      content: Row(
        children: [
          const SizedBox(width: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BalunImage(
              imageUrl: icon,
              fit: BoxFit.cover,
              height: 44,
              width: 44,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: context.textStyles.snackbar.copyWith(
                color: context.colors.primaryForeground,
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: context.colors.accentLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: context.colors.primaryForeground,
          width: 2,
        ),
      ),
    ),
  );
}
