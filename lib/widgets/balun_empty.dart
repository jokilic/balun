import 'package:flutter/material.dart';

import '../theme/icons.dart';
import '../theme/theme.dart';
import 'balun_image.dart';

class BalunEmpty extends StatelessWidget {
  final String message;
  final bool isSmall;

  const BalunEmpty({
    required this.message,
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
                imageUrl: BalunIcons.ball,
                height: isSmall ? 120 : 144,
                width: isSmall ? 120 : 144,
              ),
            ),
            SizedBox(height: isSmall ? 16 : 32),
            Text(
              message,
              style: context.textStyles.error.copyWith(
                fontSize: isSmall ? 20 : null,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}
