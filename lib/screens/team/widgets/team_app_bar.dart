import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../widgets/balun_button.dart';

class TeamAppBar extends StatelessWidget {
  final Function() onPressed;
  final String teamName;

  const TeamAppBar({
    required this.onPressed,
    required this.teamName,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          ///
          /// BACK
          ///
          BalunButton(
            onPressed: onPressed,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.white.withOpacity(0.4),
              ),
              child: const Icon(
                Icons.arrow_back,
                size: 32,
              ),
            ),
          ),

          const SizedBox(width: 20),

          ///
          /// TEXT
          ///
          Expanded(
            child: Text(
              teamName,
              style: context.textStyles.matchLeagueName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
}
