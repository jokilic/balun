import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/sidelined/sidelined_inner_response.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/date_time.dart';
import '../../../../../../widgets/balun_image.dart';

class PlayerSidelinedListTile extends StatelessWidget {
  final SidelinedInnerResponse sidelined;

  const PlayerSidelinedListTile({
    required this.sidelined,
  });

  @override
  Widget build(BuildContext context) {
    final startLocal = parseTimestamp(
      sidelined.start,
    );
    final endLocal = parseTimestamp(
      sidelined.end,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///
          /// TYPE
          ///
          if (sidelined.type != null)
            Text(
              sidelined.type!,
              style: context.textStyles.titleMdBold,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

          ///
          /// START
          ///
          if (startLocal != null)
            Row(
              children: [
                BalunImage(
                  imageUrl: BalunIcons.playerOut,
                  height: 28,
                  width: 28,
                  color: context.colors.danger,
                ),
                const SizedBox(width: 8),
                Text(
                  DateFormat(
                    'd. MMMM y.',
                    context.locale.toLanguageTag(),
                  ).format(startLocal),
                  style: context.textStyles.bodyMdLightMuted,
                  textAlign: TextAlign.center,
                ),
              ],
            ),

          ///
          /// END
          ///
          if (endLocal != null)
            Row(
              children: [
                BalunImage(
                  imageUrl: BalunIcons.playerIn,
                  height: 28,
                  width: 28,
                  color: context.colors.success,
                ),
                const SizedBox(width: 8),
                Text(
                  DateFormat(
                    'd. MMMM y.',
                    context.locale.toLanguageTag(),
                  ).format(endLocal),
                  style: context.textStyles.bodyMdLightMuted,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
