import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../constants.dart';
import '../../../../models/coaches/coach_response.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/balun_image.dart';
import '../coach_app_bar.dart';

class CoachMainInfo extends WatchingWidget {
  final CoachResponse coach;

  const CoachMainInfo({
    required this.coach,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ///
            /// BACK & LEAGUE
            ///
            CoachAppBar(
              onPressed: Navigator.of(context).pop,
              coach: coach,
            ),

            const SizedBox(height: 48),

            ///
            /// LOGO
            ///
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: BalunImage(
                imageUrl: coach.photo ?? BalunImages.placeholderLogo,
                height: 120,
                width: 120,
              ),
            ),

            const SizedBox(height: 16),

            ///
            /// NAME
            ///
            Text(
              '${coach.firstName} ${coach.lastName}',
              style: context.textStyles.leagueName,
              textAlign: TextAlign.center,
            ),

            ///
            /// COUNTRY
            ///
            Text(
              coach.nationality ?? '---',
              style: context.textStyles.leagueCountry,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
}
