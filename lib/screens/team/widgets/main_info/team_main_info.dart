import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../models/teams/team_response.dart';
import '../../../../theme/icons.dart';
import '../../../../theme/theme.dart';
import '../../../../util/custom_page_scroll_physics.dart';
import '../../../../util/dependencies.dart';
import '../../../../util/team_seasons.dart';
import '../../../../widgets/balun_button.dart';
import '../../../../widgets/balun_image.dart';
import '../../controllers/team_season_controller.dart';
import '../team_app_bar.dart';

class TeamMainInfo extends WatchingWidget {
  final TeamResponse team;

  const TeamMainInfo({
    required this.team,
  });

  @override
  Widget build(BuildContext context) {
    final seasonState = watchIt<TeamSeasonController>(
      instanceName: '${team.team?.id}',
    ).value;

    final years = generateYearList();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),

          ///
          /// BACK & TEAM NAME
          ///
          TeamAppBar(
            onPressed: Navigator.of(context).pop,
            team: team.team,
          ),

          const SizedBox(height: 48),

          ///
          /// LOGO
          ///
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BalunImage(
              imageUrl: team.team?.logo ?? BalunIcons.placeholderTeam,
              fit: BoxFit.contain,
              height: 120,
              width: 120,
            ),
          ),

          const SizedBox(height: 16),

          ///
          /// NAME
          ///
          Text(
            team.team?.name ?? '---',
            style: context.textStyles.leagueName,
            textAlign: TextAlign.center,
          ),

          ///
          /// COUNTRY
          ///
          if (team.team?.country != null)
            Text(
              team.team?.country ?? '---',
              style: context.textStyles.leagueCountry,
              textAlign: TextAlign.center,
            ),

          ///
          /// FOUNDED
          ///
          if (team.team?.founded != null) ...[
            const SizedBox(height: 4),
            Text(
              'Founded ${team.team?.founded}',
              style: context.textStyles.teamFounded,
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 8),

          ///
          /// SEASON TITLE
          ///
          Text(
            'Season',
            style: context.textStyles.leagueSeason,
            textAlign: TextAlign.center,
          ),

          ///
          /// SEASONS
          ///
          SizedBox(
            height: 48,
            width: 200,
            child: PageView(
              controller: getIt
                  .get<TeamSeasonController>(
                    instanceName: '${team.team?.id}',
                  )
                  .controller,
              physics: const CustomPageScrollPhysics(
                viewportFraction: 0.4,
              ),
              children: List.generate(
                years.length,
                (index) {
                  final year = years[index];

                  return BalunButton(
                    onPressed: () => getIt
                        .get<TeamSeasonController>(
                          instanceName: '${team.team?.id}',
                        )
                        .updateState(year),
                    child: Center(
                      child: Text(
                        '$year',
                        style: seasonState == year ? context.textStyles.seasonPickerActive : context.textStyles.seasonPickerInactive,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
