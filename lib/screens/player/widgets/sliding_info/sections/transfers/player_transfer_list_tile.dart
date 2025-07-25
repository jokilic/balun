import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/transfers/transfer/transfer.dart';
import '../../../../../../routing.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/date_time.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image/balun_image.dart';

class PlayerTransferListTile extends StatelessWidget {
  final Transfer transfer;

  const PlayerTransferListTile({
    required this.transfer,
  });

  @override
  Widget build(BuildContext context) {
    final dateLocal = parseTimestamp(
      transfer.date,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ///
          /// OUT
          ///
          if (transfer.teams?.teamOut != null)
            Expanded(
              child: BalunButton(
                onPressed: transfer.teams?.teamOut?.id != null
                    ? () => openTeam(
                        context,
                        teamId: transfer.teams!.teamOut!.id!,
                        season: (dateLocal?.year ?? getCurrentSeasonYear()).toString(),
                      )
                    : null,
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      BalunImage(
                        imageUrl: BalunIcons.playerOut,
                        height: 28,
                        width: 28,
                        color: context.colors.danger,
                      ),
                      const SizedBox(height: 8),
                      BalunImage(
                        imageUrl: transfer.teams?.teamOut?.logo ?? BalunIcons.placeholderTeam,
                        height: 48,
                        width: 48,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        mixOrOriginalWords(transfer.teams?.teamOut?.name) ?? '---',
                        style: context.textStyles.teamTransferTeam,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),

          const SizedBox(width: 8),

          ///
          /// PRICE
          ///
          Expanded(
            child: Column(
              children: [
                ///
                /// DATE
                ///
                if (dateLocal != null) ...[
                  Text(
                    DateFormat(
                      'd. MMMM y.',
                      context.locale.toLanguageTag(),
                    ).format(dateLocal),
                    style: context.textStyles.teamTransferTeam,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                ],

                if (transfer.type != null) ...[
                  Text(
                    'playerTransferPrice'.tr(),
                    style: context.textStyles.teamCoachCareerTitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    transfer.type!,
                    style: context.textStyles.teamCoachCareerValue,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                ],
              ],
            ),
          ),

          const SizedBox(width: 8),

          ///
          /// IN
          ///
          if (transfer.teams?.teamIn != null)
            Expanded(
              child: BalunButton(
                onPressed: transfer.teams?.teamIn?.id != null
                    ? () => openTeam(
                        context,
                        teamId: transfer.teams!.teamIn!.id!,
                        season: (dateLocal?.year ?? getCurrentSeasonYear()).toString(),
                      )
                    : null,
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      BalunImage(
                        imageUrl: BalunIcons.playerIn,
                        height: 28,
                        width: 28,
                        color: context.colors.accentStrong,
                      ),
                      const SizedBox(height: 8),
                      BalunImage(
                        imageUrl: transfer.teams?.teamIn?.logo ?? BalunIcons.placeholderTeam,
                        height: 48,
                        width: 48,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        mixOrOriginalWords(transfer.teams?.teamIn?.name) ?? '---',
                        style: context.textStyles.teamTransferTeam,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
