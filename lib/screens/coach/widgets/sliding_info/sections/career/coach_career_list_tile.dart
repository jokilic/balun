import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/coaches/career/career.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/date_time.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';

class CoachCareerListTile extends StatelessWidget {
  final Career careerValue;

  const CoachCareerListTile({
    required this.careerValue,
  });

  @override
  Widget build(BuildContext context) {
    final startDate = parseTimestamp(
      careerValue.start,
    );
    final endDate = parseTimestamp(
      careerValue.end,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BalunButton(
            onPressed: careerValue.team?.id != null
                ? () => openTeam(
                      context,
                      teamId: careerValue.team!.id!,
                      season: careerValue.start?.year ?? DateTime.now().year,
                    )
                : null,
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: BalunImage(
                      imageUrl: careerValue.team?.logo ?? BalunImages.placeholderLogo,
                      height: 40,
                      width: 40,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    careerValue.team?.name ?? 'Unknown',
                    style: context.textStyles.countriesName,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 58),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Start',
                  style: context.textStyles.teamTransferTeam,
                ),
                Text(
                  startDate != null ? DateFormat('d. MMMM y.').format(startDate) : '---',
                  style: context.textStyles.teamCoachCareerValue,
                ),
                const SizedBox(height: 16),
                Text(
                  'End',
                  style: context.textStyles.teamTransferTeam,
                ),
                Text(
                  endDate != null ? DateFormat('d. MMMM y.').format(endDate) : '---',
                  style: context.textStyles.teamCoachCareerValue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
