import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../constants.dart';
import '../../../../models/teams/team_response.dart';
import '../../../../theme/icons.dart';
import '../../../../theme/theme.dart';
import '../../../../util/dependencies.dart';
import '../../../../util/team_seasons.dart';
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
              imageUrl: team.team?.logo ?? BalunImages.placeholderLogo,
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
          /// SEASON
          ///
          Text(
            'Season',
            style: context.textStyles.leagueSeason,
            textAlign: TextAlign.center,
          ),

          // TODO: Use `PageView` here
          DropdownButton<int>(
            onChanged: getIt
                .get<TeamSeasonController>(
                  instanceName: '${team.team?.id}',
                )
                .updateState,
            value: seasonState,
            borderRadius: BorderRadius.circular(8),
            dropdownColor: context.colors.white,
            style: context.textStyles.leagueSeasonDropdown,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Image.asset(
                BalunIcons.arrowDown,
                color: context.colors.black,
                height: 20,
                width: 20,
              ),
            ),
            items: years
                .map(
                  (year) => DropdownMenuItem(
                    value: year,
                    child: Text(
                      '$year',
                      style: context.textStyles.leagueSeasonDropdown,
                    ),
                  ),
                )
                .toList(),
            selectedItemBuilder: (context) => years
                .map(
                  (year) => Center(
                    child: Text(
                      '$year',
                      style: context.textStyles.leagueSeasonDropdown.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
