import 'package:flutter/material.dart';

import '../theme/icons.dart';
import '../theme/theme.dart';
import 'balun_button.dart';
import 'balun_image.dart';

class BalunEmpty extends StatelessWidget {
  final String message;
  final String? smallMessage;
  final bool isSmall;
  final bool hasBackButton;

  const BalunEmpty({
    required this.message,
    this.smallMessage,
    this.isSmall = false,
    this.hasBackButton = false,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasBackButton) ...[
          const SizedBox(height: 12),

          BalunButton(
            onPressed: Navigator.of(context).pop,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.primaryBackgroundLight,
              ),
              child: BalunImage(
                imageUrl: BalunIcons.back,
                height: 32,
                width: 32,
                color: context.colors.primaryForeground,
              ),
            ),
          ),

          const SizedBox(height: 48),
        ],

        ///
        /// CONTENT
        ///
        Center(
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
                  color: context.colors.primaryForeground,
                ),
              ),
              SizedBox(height: isSmall ? 8 : 16),
              Text(
                message,
                style: context.textStyles.headlineMd.copyWith(
                  fontSize: isSmall ? 20 : 24,
                ),
                textAlign: TextAlign.center,
              ),
              if (smallMessage != null) ...[
                SizedBox(height: isSmall ? 2 : 4),
                Text(
                  smallMessage!,
                  style: context.textStyles.headlineMd.copyWith(
                    fontSize: isSmall ? 14 : 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}
