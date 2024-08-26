import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../widgets/balun_button.dart';

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
            /// BACK
            ///
            BalunButton(
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.white.withOpacity(0.4),
                ),
                // TODO: Icon here
                child: const SizedBox(
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
              child: Text(
                'Countries',
                style: context.textStyles.matchLeagueName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
}
