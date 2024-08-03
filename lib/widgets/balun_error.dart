import 'package:flutter/material.dart';

import '../theme/icons.dart';
import '../theme/theme.dart';

class BalunError extends StatelessWidget {
  final String error;

  const BalunError({
    required this.error,
  });

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                BalunIcons.error,
                height: 144,
                width: 144,
              ),
              const SizedBox(height: 40),
              Text(
                error,
                style: context.textStyles.error,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
}
