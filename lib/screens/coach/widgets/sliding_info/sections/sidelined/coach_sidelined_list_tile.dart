import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../models/sidelined/sidelined_inner_response.dart';
import '../../../../../../theme/icons.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/date_time.dart';

class CoachSidelinedListTile extends StatelessWidget {
  final SidelinedInnerResponse sidelined;

  const CoachSidelinedListTile({
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
              style: context.textStyles.teamCoachCareerTeam,
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
                Image.asset(
                  BalunIcons.playerOut,
                  height: 28,
                  width: 28,
                  color: context.colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  DateFormat('d. MMMM y.').format(startLocal),
                  style: context.textStyles.leagueTeamsCountry,
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
                Image.asset(
                  BalunIcons.playerIn,
                  height: 28,
                  width: 28,
                  color: context.colors.green,
                ),
                const SizedBox(width: 8),
                Text(
                  DateFormat('d. MMMM y.').format(endLocal),
                  style: context.textStyles.leagueTeamsCountry,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
        ],
      ),
    );
  }
}