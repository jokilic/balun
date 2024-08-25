import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../models/coaches/coach_response.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/date_time.dart';

class CoachInfoSection extends StatelessWidget {
  final CoachResponse? coach;

  const CoachInfoSection({
    required this.coach,
  });

  @override
  Widget build(BuildContext context) {
    final birthDate = parseTimestamp(
      coach?.birth?.date,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        children: [
          ///
          /// NAME & AGE
          ///
          if (coach?.name != null || coach?.age != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///
                /// NAME
                ///
                if (coach?.name != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: context.textStyles.matchInfoSectionTitle,
                        ),
                        Text(
                          coach!.name!,
                          style: context.textStyles.matchInfoSectionText,
                        ),
                      ],
                    ),
                  ),

                const SizedBox(width: 24),

                ///
                /// AGE
                ///
                if (coach?.age != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Age',
                          style: context.textStyles.matchInfoSectionTitle,
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          '${coach!.age!}',
                          style: context.textStyles.matchInfoSectionText,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
              ],
            ),

          const SizedBox(height: 24),

          ///
          /// BIRTH INFO
          ///
          if (coach?.birth != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///
                /// BIRTH PLACE
                ///
                if (coach?.birth?.place != null || coach?.birth?.country != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Birth place',
                          style: context.textStyles.matchInfoSectionTitle,
                        ),
                        if (coach?.birth?.place != null)
                          Text(
                            coach!.birth!.place!,
                            style: context.textStyles.matchInfoSectionText,
                          ),
                        if (coach?.birth?.country != null)
                          Text(
                            coach!.birth!.country ?? '---',
                            style: context.textStyles.matchInfoSectionText,
                          ),
                      ],
                    ),
                  ),

                const SizedBox(width: 24),

                ///
                /// BIRTH DATE
                ///
                if (birthDate != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Birth date',
                          style: context.textStyles.matchInfoSectionTitle,
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          DateFormat('d. MMMM y.').format(birthDate),
                          style: context.textStyles.matchInfoSectionText,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
              ],
            ),

          const SizedBox(height: 24),

          ///
          /// HEIGHT & WEIGHT
          ///
          if (coach?.height != null || coach?.weight != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///
                /// HEIGHT
                ///
                if (coach?.height != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Height',
                          style: context.textStyles.matchInfoSectionTitle,
                        ),
                        Text(
                          coach!.height!,
                          style: context.textStyles.matchInfoSectionText,
                        ),
                      ],
                    ),
                  ),

                const SizedBox(width: 24),

                ///
                /// WEIGHT
                ///
                if (coach?.weight != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Weight',
                          style: context.textStyles.matchInfoSectionTitle,
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          coach!.weight!,
                          style: context.textStyles.matchInfoSectionText,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
