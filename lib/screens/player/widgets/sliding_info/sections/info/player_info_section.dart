import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/players/player/player.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/date_time.dart';
import '../../../../../../util/string.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_image/balun_image.dart';

class PlayerInfoSection extends StatelessWidget {
  final Player? player;

  const PlayerInfoSection({
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    final birthDate = parseTimestamp(
      player?.birth?.date,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        children: [
          ///
          /// INJURED
          ///
          if (player?.injured ?? false) ...[
            Row(
              children: [
                const BalunImage(
                  imageUrl: BalunIcons.injury,
                  height: 52,
                  width: 52,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    '${mixOrOriginalWords(player?.firstName)} ${'playerInfoInjured'.tr()}.',
                    style: context.textStyles.matchInfoSectionText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],

          ///
          /// NAME & AGE
          ///
          if (player?.name != null || player?.age != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///
                /// NAME
                ///
                if (player?.name != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'playerInfoName'.tr(),
                          style: context.textStyles.matchInfoSectionTitle,
                        ),
                        Text(
                          mixOrOriginalWords(player!.name) ?? '---',
                          style: context.textStyles.matchInfoSectionText,
                        ),
                      ],
                    ),
                  ),

                const SizedBox(width: 24),

                ///
                /// AGE
                ///
                if (player?.age != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'playerInfoAge'.tr(),
                          style: context.textStyles.matchInfoSectionTitle,
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          '${player!.age!}',
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
          if (player?.birth != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///
                /// BIRTH PLACE
                ///
                if (player?.birth?.place != null || player?.birth?.country != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'playerInfoBirthPlace'.tr(),
                          style: context.textStyles.matchInfoSectionTitle,
                        ),
                        if (player?.birth?.place != null)
                          Text(
                            mixOrOriginalWords(player!.birth!.place) ?? '---',
                            style: context.textStyles.matchInfoSectionText,
                          ),
                        if (player?.birth?.country != null)
                          Text(
                            mixOrOriginalWords(
                                  getCountryName(
                                    country: player!.birth!.country!,
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
                          'playerInfoBirthDate'.tr(),
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
          if (player?.height != null || player?.weight != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///
                /// HEIGHT
                ///
                if (player?.height != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'playerInfoHeight'.tr(),
                          style: context.textStyles.matchInfoSectionTitle,
                        ),
                        Text(
                          player!.height!,
                          style: context.textStyles.matchInfoSectionText,
                        ),
                      ],
                    ),
                  ),

                const SizedBox(width: 24),

                ///
                /// WEIGHT
                ///
                if (player?.weight != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'playerInfoWeight'.tr(),
                          style: context.textStyles.matchInfoSectionTitle,
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          player!.weight!,
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
