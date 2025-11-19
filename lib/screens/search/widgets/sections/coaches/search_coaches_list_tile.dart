import 'package:flutter/material.dart';

import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../models/search/search_coaches/search_coach_response.dart';
import '../../../../../theme/icons.dart';
import '../../../../../util/word_mix.dart';
import '../../../../../widgets/balun_image.dart';

class SearchCoachesListTile extends StatelessWidget {
  final SearchCoachResponse coach;
  final Function()? coachPressed;

  const SearchCoachesListTile({
    required this.coach,
    required this.coachPressed,
  });

  @override
  Widget build(BuildContext context) => BalunButton(
    onPressed: coachPressed,
    child: Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BalunImage(
              imageUrl: coach.photo ?? BalunIcons.placeholderPlayer,
              height: 40,
              width: 40,
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mixOrOriginalWords(coach.name) ?? '---',
                  style: context.textStyles.bodyLgBold,
                ),
                if (coach.nationality != null)
                  Text(
                    mixOrOriginalWords(coach.nationality) ?? '---',
                    style: context.textStyles.labelMediumMuted,
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
