import 'package:flutter/material.dart';

import '../theme/icons.dart';
import '../theme/theme.dart';
import 'balun_image.dart';

class BalunError extends StatelessWidget {
  final String error;
  final String? smallMessage;
  final bool isSmall;

  const BalunError({
    required this.error,
    this.smallMessage,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) => Center(
    child: ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: 40,
        vertical: isSmall ? 0 : 104,
      ),
      children: [
        Center(
          child: BalunImage(
            imageUrl: BalunIcons.error,
            height: isSmall ? 120 : 144,
            width: isSmall ? 120 : 144,
          ),
        ),
        SizedBox(height: isSmall ? 8 : 16),
        Text(
          error,
          style: context.textStyles.error.copyWith(
            fontSize: isSmall ? 20 : 24,
          ),
          textAlign: TextAlign.center,
        ),
        if (smallMessage != null) ...[
          SizedBox(height: isSmall ? 2 : 4),
          Text(
            smallMessage!,
            style: context.textStyles.error.copyWith(
              fontSize: isSmall ? 14 : 18,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    ),
  );
}
