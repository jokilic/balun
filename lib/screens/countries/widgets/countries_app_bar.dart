import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image/balun_image.dart';

class CountriesAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(
          children: [
            ///
            /// ICON
            ///
            BalunButton(
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.white.withValues(alpha: 0.4),
                ),
                child: BalunImage(
                  imageUrl: BalunIcons.globe,
                  height: 32,
                  width: 32,
                  color: context.colors.black,
                ),
              ),
            ),

            const SizedBox(width: 14),

            ///
            /// TEXT
            ///
            Expanded(
              child: Text(
                'countriesAppBar'.tr(),
                style: context.textStyles.matchLeagueName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
}
