import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/coaches/coach_response.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/date_time.dart';
import '../../../../../../util/string.dart';
import '../../../../../../util/word_mix.dart';

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
                          'coachInfoName'.tr(),
                          style: context.textStyles.matchInfoSectionTitle,
                        ),
                        Text(
                          mixOrOriginalWords(coach!.name) ?? '---',
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
                          'coachInfoAge'.tr(),
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
                          'coachInfoBirthPlace'.tr(),
                          style: context.textStyles.matchInfoSectionTitle,
                        ),
                        if (coach?.birth?.place != null)
                          Text(
                            mixOrOriginalWords(coach!.birth!.place) ?? '---',
                            style: context.textStyles.matchInfoSectionText,
                          ),
                        if (coach?.birth?.country != null)
                          Text(
                            mixOrOriginalWords(
                                  getCountryName(
                                    country: coach!.birth!.country!,
                                  ),
                                ) ??
                                '---',
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
                          'coachInfoBirthDate'.tr(),
                          style: context.textStyles.matchInfoSectionTitle,
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          DateFormat(
                            'd. MMMM y.',
                            context.locale.toLanguageTag(),
                          ).format(birthDate),
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
                          'coachInfoHeight'.tr(),
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
                          'coachInfoWeight'.tr(),
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
