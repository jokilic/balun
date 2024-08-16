import 'package:flutter/material.dart';

import '../theme/theme.dart';

Color? getPositionColor(String position, {required BuildContext context}) => switch (position.toLowerCase()) {
      'goalkeeper' => context.colors.yellow,
      'defender' => context.colors.blue,
      'midfielder' => context.colors.green,
      'attacker' => context.colors.red,
      _ => context.colors.black,
    };

String? getPositionText(String position) => position.substring(0, 1).toUpperCase();
