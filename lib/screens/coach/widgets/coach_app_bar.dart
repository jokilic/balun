import 'package:flutter/material.dart';

import '../../../models/coaches/coach_response.dart';
import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../util/string.dart';
import '../../../util/word_mix.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image.dart';

class CoachAppBar extends StatelessWidget {
  final Function() onPressed;
  final CoachResponse? coach;

  const CoachAppBar({
    required this.onPressed,
    required this.coach,
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
            color: context.colors.primaryBackground.withValues(alpha: 0.4),
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
            if (coach?.name != null)
              Text(
                mixOrOriginalWords(coach!.name) ?? '---',
                style: context.textStyles.titleLgBold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            if (coach?.nationality != null)
              Text(
                mixOrOriginalWords(
                      getCountryName(
                        country: coach!.nationality!,
                      ),
                    ) ??
                    '---',
                style: context.textStyles.labelMediumMuted,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    ],
  );
}
