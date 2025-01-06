import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../util/string.dart';
import '../../../util/word_mix.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image/balun_image.dart';

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
                  color: context.colors.white.withValues(alpha: 0.4),
                ),
                child: const BalunImage(
                  imageUrl: BalunIcons.back,
                  height: 32,
                  width: 32,
                ),
              ),
            ),

            const SizedBox(width: 14),

            ///
            /// TEXT
            ///
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mixOrOriginalWords(
                          getCountryName(
                            country: country,
                          ),
                        ) ??
                        '---',
                    style: context.textStyles.matchLeagueName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'leaguesAppBar'.tr(),
                    style: context.textStyles.matchLeagueRound,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
