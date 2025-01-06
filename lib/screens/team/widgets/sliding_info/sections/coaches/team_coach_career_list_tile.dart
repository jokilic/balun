import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/coaches/career/career.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/date_time.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image/balun_image.dart';

class TeamCoachCareerListTile extends StatelessWidget {
  final Career career;

  const TeamCoachCareerListTile({
    required this.career,
  });

  @override
  Widget build(BuildContext context) {
    final startLocal = parseTimestamp(
      career.start,
    );
    final endLocal = parseTimestamp(
      career.end,
    );

    return BalunButton(
      onPressed: career.team?.id != null
          ? () => openTeam(
                context,
                teamId: career.team!.id!,
                season: (endLocal?.year ?? startLocal?.year ?? getCurrentSeasonYear()).toString(),
              )
          : null,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BalunImage(
                  imageUrl: career.team?.logo ?? BalunIcons.placeholderTeam,
                  height: 32,
                  width: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mixOrOriginalWords(career.team?.name) ?? '--',
                        style: context.textStyles.teamCoachCareerTeam,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (startLocal != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'coachCareerStart'.tr(),
                          style: context.textStyles.teamCoachCareerTitle,
                        ),
                        Text(
                          DateFormat(
                            'd. MMMM y.',
                            context.locale.toLanguageTag(),
                          ).format(startLocal),
                          style: context.textStyles.teamCoachCareerValue,
                        ),
                      ],
                      if (endLocal != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'coachCareerEnd'.tr(),
                          style: context.textStyles.teamCoachCareerTitle,
                        ),
                        Text(
                          DateFormat(
                            'd. MMMM y.',
                            context.locale.toLanguageTag(),
                          ).format(endLocal),
                          style: context.textStyles.teamCoachCareerValue,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
