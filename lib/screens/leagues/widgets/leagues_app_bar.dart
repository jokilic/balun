import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../widgets/balun_button.dart';

class LeaguesAppBar extends StatelessWidget {
  final Function() onPressed;
  final String country;

  const LeaguesAppBar({
    required this.onPressed,
    required this.country,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(
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
                  Icons.arrow_back_rounded,
                  size: 32,
                ),
              ),
            ),

            const SizedBox(width: 20),

            ///
            /// TEXT
            ///
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country,
                    style: context.textStyles.matchLeagueName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Leagues',
                    style: context.textStyles.matchLeagueRound,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
