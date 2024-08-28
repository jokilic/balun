import 'package:flutter/material.dart';

import '../../../models/fixtures/league/league.dart';
import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../widgets/balun_button.dart';

class MatchAppBar extends StatelessWidget {
  final Function() onPressed;
  final League league;

  const MatchAppBar({
    required this.onPressed,
    required this.league,
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
              child: Image.asset(
                BalunIcons.back,
                height: 32,
                width: 32,
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
                if (league.name != null)
                  Text(
                    league.name!,
                    style: context.textStyles.matchLeagueName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (league.round != null)
                  Text(
                    league.round!,
                    style: context.textStyles.matchLeagueRound,
                  ),
              ],
            ),
          ),
        ],
      );
}
